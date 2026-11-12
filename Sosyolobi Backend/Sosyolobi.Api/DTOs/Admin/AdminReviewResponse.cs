using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class AdminReviewResponse
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public string ActivityTitle { get; set; } = null!;
    public Guid ReviewerUserId { get; set; }
    public string ReviewerDisplayName { get; set; } = null!;
    public string? ReviewerAvatarUrl { get; set; }
    public Guid ReviewedUserId { get; set; }
    public string ReviewedDisplayName { get; set; } = null!;
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public bool IsHidden { get; set; }
    public DateTime CreatedAt { get; set; }
}
