using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Friends;

public class FriendRequestResponse
{
    public Guid Id { get; set; }
    public FriendRequestStatus Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? RespondedAt { get; set; }
    public PublicProfileResponse User { get; set; } = null!;
}
