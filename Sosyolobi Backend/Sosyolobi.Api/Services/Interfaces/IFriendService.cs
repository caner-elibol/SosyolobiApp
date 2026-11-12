using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Friends;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IFriendService
{
    Task<FriendRequestResponse> SendRequestAsync(Guid requesterUserId, Guid addresseeUserId);
    Task<IList<FriendRequestResponse>> GetIncomingRequestsAsync(Guid userId);
    Task<IList<FriendRequestResponse>> GetSentRequestsAsync(Guid userId);
    Task AcceptAsync(Guid requestId, Guid userId);
    Task RejectAsync(Guid requestId, Guid userId);
    Task CancelAsync(Guid requestId, Guid userId);
    Task<IList<FriendResponse>> GetFriendsAsync(Guid userId);
    Task RemoveFriendAsync(Guid friendUserId, Guid userId);
    Task<IList<ActivityResponse>> GetFriendActivitiesAsync(Guid friendUserId, Guid requestingUserId);
}
