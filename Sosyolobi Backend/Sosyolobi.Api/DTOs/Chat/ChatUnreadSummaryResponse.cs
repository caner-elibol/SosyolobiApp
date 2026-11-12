namespace Sosyolobi.Api.DTOs.Chat;

public class ChatUnreadSummaryResponse
{
    public Guid ActivityId { get; set; }
    public string ActivityTitle { get; set; } = null!;
    public Guid ChatRoomId { get; set; }
    public int UnreadCount { get; set; }
}
