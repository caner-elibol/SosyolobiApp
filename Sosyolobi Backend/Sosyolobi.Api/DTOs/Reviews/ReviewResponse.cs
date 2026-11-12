namespace Sosyolobi.Api.DTOs.Reviews;

public class ReviewResponse
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public Guid ReviewerUserId { get; set; }
    public string ReviewerDisplayName { get; set; } = null!;
    public string? ReviewerAvatarUrl { get; set; }
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public DateTime CreatedAt { get; set; }
}
