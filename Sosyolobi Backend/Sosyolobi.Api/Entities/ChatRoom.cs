using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Entities;

public class ChatRoom
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public ChatRoomStatus Status { get; set; } = ChatRoomStatus.Open;
    public DateTime CreatedAt { get; set; }
    public DateTime? ClosedAt { get; set; }

    public Activity Activity { get; set; } = null!;
    public ICollection<ChatMessage> Messages { get; set; } = new List<ChatMessage>();
}
