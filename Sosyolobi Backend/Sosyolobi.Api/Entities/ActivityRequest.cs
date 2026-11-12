using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Entities;

public class ActivityRequest
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public Guid UserId { get; set; }
    public string? Message { get; set; }
    public ActivityRequestStatus Status { get; set; } = ActivityRequestStatus.Pending;
    public DateTime CreatedAt { get; set; }
    public DateTime? RespondedAt { get; set; }

    public Activity Activity { get; set; } = null!;
    public User User { get; set; } = null!;
}
