namespace Sosyolobi.Api.Entities;

public class ChatMessage
{
    public Guid Id { get; set; }
    public Guid ChatRoomId { get; set; }
    public Guid SenderUserId { get; set; }
    public string Content { get; set; } = null!;
    public Guid? ReplyToMessageId { get; set; }
    public DateTime CreatedAt { get; set; }

    public ChatRoom ChatRoom { get; set; } = null!;
    public User SenderUser { get; set; } = null!;
    public ChatMessage? ReplyToMessage { get; set; }
}
