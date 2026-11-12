using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Chat;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Authorize]
public class ChatController : ControllerBase
{
    private readonly IChatService _chatService;

    public ChatController(IChatService chatService) => _chatService = chatService;

    [HttpGet("api/activities/{activityId:guid}/chat-room")]
    public async Task<IActionResult> GetRoomForActivity(Guid activityId)
    {
        var userId = User.GetUserId();
        var result = await _chatService.GetRoomForActivityAsync(activityId, userId);
        return Ok(ApiResponse<ChatRoomResponse>.Ok(result));
    }

    [HttpGet("api/chat-rooms/{roomId:guid}/messages")]
    public async Task<IActionResult> GetMessages(Guid roomId, [FromQuery] PagedRequest paged)
    {
        var userId = User.GetUserId();
        var result = await _chatService.GetMessagesAsync(roomId, userId, paged);
        return Ok(ApiResponse<PagedResponse<ChatMessageResponse>>.Ok(result));
    }

    [HttpPost("api/chat-rooms/{roomId:guid}/messages")]
    public async Task<IActionResult> SendMessage(Guid roomId, [FromBody] SendChatMessageRequest request)
    {
        var userId = User.GetUserId();
        var result = await _chatService.SendMessageAsync(roomId, userId, request);
        return Ok(ApiResponse<ChatMessageResponse>.Ok(result));
    }

    [HttpGet("api/chat-rooms/unread-summary")]
    public async Task<IActionResult> GetUnreadSummary()
    {
        var userId = User.GetUserId();
        var result = await _chatService.GetUnreadSummaryAsync(userId);
        return Ok(ApiResponse<IList<ChatUnreadSummaryResponse>>.Ok(result));
    }

    [HttpPost("api/chat-rooms/{roomId:guid}/read")]
    public async Task<IActionResult> MarkRoomRead(Guid roomId)
    {
        var userId = User.GetUserId();
        await _chatService.MarkRoomReadAsync(roomId, userId);
        return Ok(ApiResponse<object>.Ok(null));
    }
}
