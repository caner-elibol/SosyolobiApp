using Sosyolobi.Api.DTOs.Chat;
using Sosyolobi.Api.DTOs.Common;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IChatService
{
    Task<ChatRoomResponse> GetRoomForActivityAsync(Guid activityId, Guid userId);
    Task<PagedResponse<ChatMessageResponse>> GetMessagesAsync(Guid roomId, Guid userId, PagedRequest paged);
    Task<ChatMessageResponse> SendMessageAsync(Guid roomId, Guid userId, SendChatMessageRequest request);
    Task<IList<ChatUnreadSummaryResponse>> GetUnreadSummaryAsync(Guid userId);
    Task MarkRoomReadAsync(Guid roomId, Guid userId);
}
