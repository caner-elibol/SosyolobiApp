using Sosyolobi.Api.DTOs.ActivityRequests;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IActivityRequestService
{
    Task<ActivityJoinRequestResponse> JoinAsync(Guid activityId, Guid userId, JoinActivityRequest request);
    Task<IList<ActivityJoinRequestResponse>> GetRequestsAsync(Guid activityId, Guid requestingUserId);
    Task<IList<ActivityJoinRequestResponse>> GetSentRequestsAsync(Guid userId);
    Task<IList<ActivityJoinRequestResponse>> GetIncomingRequestsAsync(Guid userId);
    Task ApproveAsync(Guid requestId, Guid userId);
    Task RejectAsync(Guid requestId, Guid userId);
    Task CancelAsync(Guid requestId, Guid userId);
}
