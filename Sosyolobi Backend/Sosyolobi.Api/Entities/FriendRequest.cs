using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Entities;

public class FriendRequest
{
    public Guid Id { get; set; }
    public Guid RequesterUserId { get; set; }
    public Guid AddresseeUserId { get; set; }
    public FriendRequestStatus Status { get; set; } = FriendRequestStatus.Pending;
    public DateTime CreatedAt { get; set; }
    public DateTime? RespondedAt { get; set; }

    public User RequesterUser { get; set; } = null!;
    public User AddresseeUser { get; set; } = null!;
}
