using Sosyolobi.Api.DTOs.Auth;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IAuthService
{
    Task SendOtpAsync(SendOtpRequest request);
    Task<AuthResponse> VerifyOtpAsync(VerifyOtpRequest request);
    Task<AuthResponse> LoginAsync(AdminLoginRequest request);
    Task<AuthResponse> RefreshTokenAsync(RefreshTokenRequest request);
    Task LogoutAsync(Guid userId, string refreshToken);
    Task<DTOs.Profiles.ProfileResponse> GetMeAsync(Guid userId);
}
