namespace Sosyolobi.Api.DTOs.Chat;

public class SendChatMessageRequest
{
    public string Content { get; set; } = null!;
    public Guid? ReplyToMessageId { get; set; }
}
