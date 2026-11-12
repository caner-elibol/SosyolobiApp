using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Entities;

public class User
{
    public Guid Id { get; set; }
    public string PhoneNumber { get; set; } = null!;
    public bool IsPhoneVerified { get; set; }
    public string? Email { get; set; }
    public string? PasswordHash { get; set; }
    public string Role { get; set; } = "User";
    public UserStatus Status { get; set; } = UserStatus.Active;
    public DateTime CreatedAt { get; set; }
    public DateTime? LastLoginAt { get; set; }

    public UserProfile? Profile { get; set; }
    public ICollection<RefreshToken> RefreshTokens { get; set; } = new List<RefreshToken>();
}
