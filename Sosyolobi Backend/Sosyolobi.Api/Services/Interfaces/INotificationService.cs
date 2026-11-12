using Sosyolobi.Api.DTOs.Notifications;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Services.Interfaces;

public interface INotificationService
{
    Task<IList<NotificationResponse>> GetUserNotificationsAsync(Guid userId);
    Task MarkAsReadAsync(Guid notificationId, Guid userId);
    Task MarkAllAsReadAsync(Guid userId);
    Task SendAsync(Guid userId, NotificationType type, string title, string? body, Guid? relatedActivityId = null);
}
