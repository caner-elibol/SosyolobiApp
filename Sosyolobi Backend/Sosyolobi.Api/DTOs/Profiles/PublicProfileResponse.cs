namespace Sosyolobi.Api.DTOs.Profiles;

public class PublicProfileResponse
{
    public Guid UserId { get; set; }
    public string DisplayName { get; set; } = null!;
    public string? Bio { get; set; }
    public string? AvatarUrl { get; set; }
    public double AverageRating { get; set; }
    public int ReviewCount { get; set; }
    public int CompletedActivityCount { get; set; }
}
