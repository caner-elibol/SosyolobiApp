using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Chat;

public class ChatRoomResponse
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public ChatRoomStatus Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? ClosedAt { get; set; }
}
