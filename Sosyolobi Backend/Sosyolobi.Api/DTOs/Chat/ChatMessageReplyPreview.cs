namespace Sosyolobi.Api.DTOs.Chat;

public class ChatMessageReplyPreview
{
    public Guid Id { get; set; }
    public string SenderDisplayName { get; set; } = string.Empty;
    public string Content { get; set; } = null!;
}
