using Sosyolobi.Api.DTOs.Profiles;

namespace Sosyolobi.Api.DTOs.Friends;

public class FriendResponse
{
    public DateTime FriendsSinceUtc { get; set; }
    public PublicProfileResponse User { get; set; } = null!;
}
