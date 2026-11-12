namespace Sosyolobi.Api.DTOs.Reviews;

public class CreateReviewRequest
{
    public Guid ActivityId { get; set; }
    public Guid ReviewedUserId { get; set; }
    public int Rating { get; set; }
    public string? Comment { get; set; }
}
