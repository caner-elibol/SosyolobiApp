namespace Sosyolobi.Api.Entities;

public class ChatRoomRead
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public Guid ChatRoomId { get; set; }
    public DateTime LastReadAt { get; set; }

    public User User { get; set; } = null!;
    public ChatRoom ChatRoom { get; set; } = null!;
}
