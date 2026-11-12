using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ProfileService : IProfileService
{
    private static readonly HashSet<string> AllowedContentTypes = new(StringComparer.OrdinalIgnoreCase)
    {
        "image/jpeg", "image/png", "image/webp"
    };
    private const long MaxAvatarSizeBytes = 5 * 1024 * 1024;

    private readonly AppDbContext _db;
    private readonly IWebHostEnvironment _env;

    public ProfileService(AppDbContext db, IWebHostEnvironment env)
    {
        _db = db;
        _env = env;
    }

    public async Task<ProfileResponse?> GetMyProfileAsync(Guid userId)
    {
        var user = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == userId);
        if (user is null) return null;

        return Map(user);
    }

    public async Task<ProfileResponse> UpdateProfileAsync(Guid userId, UpdateProfileRequest request)
    {
        var user = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        if (user.Profile is null)
        {
            user.Profile = new UserProfile
            {
                Id = Guid.CreateVersion7(),
                UserId = userId,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            _db.UserProfiles.Add(user.Profile);
        }

        user.Profile.DisplayName = request.DisplayName;
        if (request.Bio is not null) user.Profile.Bio = request.Bio;
        if (request.AvatarUrl is not null) user.Profile.AvatarUrl = request.AvatarUrl;
        if (request.BirthDate.HasValue) user.Profile.BirthDate = request.BirthDate;
        user.Profile.UpdatedAt = DateTime.UtcNow;

        await _db.SaveChangesAsync();
        return Map(user);
    }

    public async Task<ProfileResponse> UploadAvatarAsync(Guid userId, IFormFile file, string baseUrl)
    {
        if (file.Length == 0)
            throw new ArgumentException("Dosya boş.");
        if (file.Length > MaxAvatarSizeBytes)
            throw new ArgumentException("Dosya boyutu 5 MB'ı aşamaz.");
        if (!AllowedContentTypes.Contains(file.ContentType))
            throw new ArgumentException("Sadece JPEG, PNG veya WEBP yüklenebilir.");

        var user = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        var extension = file.ContentType switch
        {
            "image/jpeg" => ".jpg",
            "image/png" => ".png",
            "image/webp" => ".webp",
            _ => ".jpg"
        };
        var fileName = $"{Guid.CreateVersion7()}{extension}";
        var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
        var uploadsDir = Path.Combine(webRoot, "avatars");
        Directory.CreateDirectory(uploadsDir);
        var filePath = Path.Combine(uploadsDir, fileName);

        using (var stream = new FileStream(filePath, FileMode.Create))
            await file.CopyToAsync(stream);

        if (user.Profile is null)
        {
            user.Profile = new UserProfile
            {
                Id = Guid.CreateVersion7(),
                UserId = userId,
                DisplayName = string.Empty,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            _db.UserProfiles.Add(user.Profile);
        }

        user.Profile.AvatarUrl = $"{baseUrl}/avatars/{fileName}";
        user.Profile.UpdatedAt = DateTime.UtcNow;

        await _db.SaveChangesAsync();
        return Map(user);
    }

    private static ProfileResponse Map(User user) => new()
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
