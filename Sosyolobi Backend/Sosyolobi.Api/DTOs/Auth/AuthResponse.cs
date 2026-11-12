namespace Sosyolobi.Api.DTOs.Auth;

public class AuthResponse
{
    public string AccessToken { get; set; } = null!;
    public string RefreshToken { get; set; } = null!;
    public DateTime ExpiresAt { get; set; }
    public Guid UserId { get; set; }
    public string Role { get; set; } = null!;
    public string? DisplayName { get; set; }
    public bool IsNewUser { get; set; }
}
