using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Notifications;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/notifications")]
[Authorize]
public class NotificationsController : ControllerBase
{
    private readonly INotificationService _notificationService;

    public NotificationsController(INotificationService notificationService) => _notificationService = notificationService;

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var userId = User.GetUserId();
        var result = await _notificationService.GetUserNotificationsAsync(userId);
        return Ok(ApiResponse<IList<NotificationResponse>>.Ok(result));
    }

    [HttpPost("{id:guid}/read")]
    public async Task<IActionResult> MarkAsRead(Guid id)
    {
        var userId = User.GetUserId();
        await _notificationService.MarkAsReadAsync(id, userId);
        return Ok(ApiResponse<object>.Ok(null));
    }

    [HttpPost("read-all")]
    public async Task<IActionResult> MarkAllAsRead()
    {
        var userId = User.GetUserId();
        await _notificationService.MarkAllAsReadAsync(userId);
        return Ok(ApiResponse<object>.Ok(null));
    }
}
