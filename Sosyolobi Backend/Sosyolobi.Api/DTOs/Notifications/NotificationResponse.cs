using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Notifications;

public class NotificationResponse
{
    public Guid Id { get; set; }
    public NotificationType Type { get; set; }
    public string Title { get; set; } = null!;
    public string? Message { get; set; }
    public Guid? RelatedActivityId { get; set; }
    public string? RelatedActivityTitle { get; set; }
    public bool IsRead { get; set; }
    public DateTime CreatedAt { get; set; }
}
