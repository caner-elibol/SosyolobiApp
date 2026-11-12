namespace Sosyolobi.Api.DTOs.Chat;

public class ChatMessageResponse
{
    public Guid Id { get; set; }
    public Guid ChatRoomId { get; set; }
    public Guid SenderUserId { get; set; }
    public string SenderDisplayName { get; set; } = string.Empty;
    public string? SenderAvatarUrl { get; set; }
    public string Content { get; set; } = null!;
    public ChatMessageReplyPreview? ReplyTo { get; set; }
    public DateTime CreatedAt { get; set; }
}
