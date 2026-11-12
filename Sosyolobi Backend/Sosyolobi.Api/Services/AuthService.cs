using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Auth;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Helpers;
using Sosyolobi.Api.Options;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class AuthService : IAuthService
{
    private readonly AppDbContext _db;
    private readonly JwtOptions _jwtOptions;
    private readonly SmsOptions _smsOptions;
    private readonly ILogger<AuthService> _logger;

    public AuthService(AppDbContext db, IOptions<JwtOptions> jwtOptions, IOptions<SmsOptions> smsOptions, ILogger<AuthService> logger)
    {
        _db = db;
        _jwtOptions = jwtOptions.Value;
        _smsOptions = smsOptions.Value;
        _logger = logger;
    }

    public async Task SendOtpAsync(SendOtpRequest request)
    {
        var phone = PhoneNumberHelper.Normalize(request.PhoneNumber);
        if (!PhoneNumberHelper.IsValid(phone))
            throw new ArgumentException("Geçersiz telefon numarası.");

        var code = _smsOptions.DevelopmentMode
            ? (_smsOptions.DevelopmentFixedCode ?? "123456")
            : GenerateOtpCode();

        var codeHash = HashCode(code);

        var record = new PhoneVerificationCode
        {
            Id = Guid.CreateVersion7(),
            PhoneNumber = phone,
            CodeHash = codeHash,
            ExpiresAt = DateTime.UtcNow.AddMinutes(5),
            IsUsed = false,
            CreatedAt = DateTime.UtcNow
        };

        _db.PhoneVerificationCodes.Add(record);
        await _db.SaveChangesAsync();

        if (_smsOptions.DevelopmentMode)
            _logger.LogInformation("[DEV] OTP for {Phone}: {Code}", phone, code);
        // TODO: SMS provider integration
    }

    public async Task<AuthResponse> VerifyOtpAsync(VerifyOtpRequest request)
    {
        var phone = PhoneNumberHelper.Normalize(request.PhoneNumber);
        var codeHash = HashCode(request.Code);

        var record = await _db.PhoneVerificationCodes
            .Where(x => x.PhoneNumber == phone && x.CodeHash == codeHash && !x.IsUsed && x.ExpiresAt > DateTime.UtcNow)
            .OrderByDescending(x => x.CreatedAt)
            .FirstOrDefaultAsync()
            ?? throw new InvalidOperationException("Geçersiz veya süresi dolmuş kod.");

        record.IsUsed = true;

        var user = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.PhoneNumber == phone);
        var isNewUser = user is null;

        if (isNewUser)
        {
            user = new User
            {
                Id = Guid.CreateVersion7(),
                PhoneNumber = phone,
                IsPhoneVerified = true,
                CreatedAt = DateTime.UtcNow
            };
            _db.Users.Add(user);
        }
        else
        {
            user!.IsPhoneVerified = true;
            user.LastLoginAt = DateTime.UtcNow;
        }

        var refreshTokenValue = JwtHelper.GenerateRefreshToken();
        var refreshTokenEntity = new RefreshToken
        {
            Id = Guid.CreateVersion7(),
            UserId = user.Id,
            Token = refreshTokenValue,
            ExpiresAt = DateTime.UtcNow.AddDays(_jwtOptions.RefreshTokenExpirationDays),
            CreatedAt = DateTime.UtcNow
        };
        _db.RefreshTokens.Add(refreshTokenEntity);

        await _db.SaveChangesAsync();

        var accessToken = JwtHelper.GenerateAccessToken(user.Id, user.PhoneNumber, user.Role, _jwtOptions);

        return new AuthResponse
        {
            AccessToken = accessToken,
            RefreshToken = refreshTokenValue,
            ExpiresAt = DateTime.UtcNow.AddMinutes(_jwtOptions.AccessTokenExpirationMinutes),
            UserId = user.Id,
            Role = user.Role,
            DisplayName = user.Profile?.DisplayName,
            IsNewUser = isNewUser
        };
    }

    public async Task<AuthResponse> LoginAsync(AdminLoginRequest request)
    {
        var phone = PhoneNumberHelper.Normalize(request.PhoneNumber);

        var user = await _db.Users
            .Include(u => u.Profile)
            .FirstOrDefaultAsync(u => u.PhoneNumber == phone)
            ?? throw new UnauthorizedAccessException("Kullanıcı bulunamadı.");

        if (string.IsNullOrEmpty(user.PasswordHash))
            throw new UnauthorizedAccessException("Parola tabanlı giriş bu hesap için etkin değil.");

        if (!BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash))
            throw new UnauthorizedAccessException("Telefon numarası veya parola yanlış.");

        if (user.Role is not ("Admin" or "SuperAdmin"))
            throw new UnauthorizedAccessException("Bu panele erişim yetkiniz yok.");

        if (user.Status == Enums.UserStatus.Suspended || user.Status == Enums.UserStatus.Banned)
            throw new UnauthorizedAccessException("Hesap askıya alınmış veya banlı.");

        user.LastLoginAt = DateTime.UtcNow;

        var refreshTokenValue = JwtHelper.GenerateRefreshToken();
        _db.RefreshTokens.Add(new RefreshToken
        {
            Id = Guid.CreateVersion7(),
            UserId = user.Id,
            Token = refreshTokenValue,
            ExpiresAt = DateTime.UtcNow.AddDays(_jwtOptions.RefreshTokenExpirationDays),
            CreatedAt = DateTime.UtcNow
        });
        await _db.SaveChangesAsync();

        var accessToken = JwtHelper.GenerateAccessToken(user.Id, user.PhoneNumber, user.Role, _jwtOptions);

        return new AuthResponse
        {
            AccessToken = accessToken,
            RefreshToken = refreshTokenValue,
            ExpiresAt = DateTime.UtcNow.AddMinutes(_jwtOptions.AccessTokenExpirationMinutes),
            UserId = user.Id,
            Role = user.Role,
            DisplayName = user.Profile?.DisplayName,
            IsNewUser = false
        };
    }

    public async Task<AuthResponse> RefreshTokenAsync(RefreshTokenRequest request)
    {
        var token = await _db.RefreshTokens
            .Include(t => t.User).ThenInclude(u => u.Profile)
            .FirstOrDefaultAsync(t => t.Token == request.RefreshToken && !t.IsRevoked && t.ExpiresAt > DateTime.UtcNow)
            ?? throw new UnauthorizedAccessException("Geçersiz refresh token.");

        token.IsRevoked = true;

        var newRefreshToken = JwtHelper.GenerateRefreshToken();
        var newTokenEntity = new RefreshToken
        {
            Id = Guid.CreateVersion7(),
            UserId = token.UserId,
            Token = newRefreshToken,
            ExpiresAt = DateTime.UtcNow.AddDays(_jwtOptions.RefreshTokenExpirationDays),
            CreatedAt = DateTime.UtcNow
        };
        _db.RefreshTokens.Add(newTokenEntity);
        await _db.SaveChangesAsync();

        var accessToken = JwtHelper.GenerateAccessToken(token.User.Id, token.User.PhoneNumber, token.User.Role, _jwtOptions);

        return new AuthResponse
        {
            AccessToken = accessToken,
            RefreshToken = newRefreshToken,
            ExpiresAt = DateTime.UtcNow.AddMinutes(_jwtOptions.AccessTokenExpirationMinutes),
            UserId = token.UserId,
            Role = token.User.Role,
            DisplayName = token.User.Profile?.DisplayName,
            IsNewUser = false
        };
    }

    public async Task LogoutAsync(Guid userId, string refreshToken)
    {
        var token = await _db.RefreshTokens
            .FirstOrDefaultAsync(t => t.UserId == userId && t.Token == refreshToken);

        if (token is not null)
        {
            token.IsRevoked = true;
            await _db.SaveChangesAsync();
        }
    }

    public async Task<ProfileResponse> GetMeAsync(Guid userId)
    {
        var user = await _db.Users.Include(u => u.Profile)
            .FirstOrDefaultAsync(u => u.Id == userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        return MapToProfileResponse(user);
    }

    private static string GenerateOtpCode()
    {
        return Random.Shared.Next(100000, 999999).ToString();
    }

    private static string HashCode(string code)
    {
        var bytes = System.Security.Cryptography.SHA256.HashData(System.Text.Encoding.UTF8.GetBytes(code));
        return Convert.ToHexString(bytes).ToLowerInvariant();
    }

    private static ProfileResponse MapToProfileResponse(User user) => new()
    {
        UserId = user.Id,
        DisplayName = user.Profile?.DisplayName ?? string.Empty,
        Bio = user.Profile?.Bio,
        AvatarUrl = user.Profile?.AvatarUrl,
        BirthDate = user.Profile?.BirthDate,
        AverageRating = user.Profile?.AverageRating ?? 0,
        ReviewCount = user.Profile?.ReviewCount ?? 0,
        CompletedActivityCount = user.Profile?.CompletedActivityCount ?? 0,
        IsPhoneVerified = user.IsPhoneVerified,
        CreatedAt = user.CreatedAt
    };
}
