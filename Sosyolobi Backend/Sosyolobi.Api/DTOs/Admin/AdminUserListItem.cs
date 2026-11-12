using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class AdminUserListItem
{
    public Guid Id { get; set; }
    public string PhoneNumber { get; set; } = null!;
    public bool IsPhoneVerified { get; set; }
    public string? Email { get; set; }
    public UserStatus Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? LastLoginAt { get; set; }

    public string DisplayName { get; set; } = null!;
    public string? AvatarUrl { get; set; }
    public double AverageRating { get; set; }
    public int ReviewCount { get; set; }
    public int CompletedActivityCount { get; set; }
}
