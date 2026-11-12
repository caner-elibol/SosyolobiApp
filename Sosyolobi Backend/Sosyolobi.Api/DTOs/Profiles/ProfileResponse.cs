namespace Sosyolobi.Api.DTOs.Profiles;

public class ProfileResponse
{
    public Guid UserId { get; set; }
    public string DisplayName { get; set; } = null!;
    public string? Bio { get; set; }
    public string? AvatarUrl { get; set; }
    public DateTime? BirthDate { get; set; }
    public double AverageRating { get; set; }
    public int ReviewCount { get; set; }
    public int CompletedActivityCount { get; set; }
    public bool IsPhoneVerified { get; set; }
    public DateTime CreatedAt { get; set; }
}
