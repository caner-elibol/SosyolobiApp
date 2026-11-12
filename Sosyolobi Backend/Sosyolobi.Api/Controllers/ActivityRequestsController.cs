using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.ActivityRequests;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Authorize]
public class ActivityRequestsController : ControllerBase
{
    private readonly IActivityRequestService _requestService;

    public ActivityRequestsController(IActivityRequestService requestService) => _requestService = requestService;

    [HttpPost("api/activities/{activityId:guid}/requests")]
    public async Task<IActionResult> Join(Guid activityId, [FromBody] JoinActivityRequest request)
    {
        var userId = User.GetUserId();
        var result = await _requestService.JoinAsync(activityId, userId, request);
        return Ok(ApiResponse<ActivityJoinRequestResponse>.Ok(result));
    }

    [HttpGet("api/activities/{activityId:guid}/requests")]
    public async Task<IActionResult> GetRequests(Guid activityId)
    {
        var userId = User.GetUserId();
        var result = await _requestService.GetRequestsAsync(activityId, userId);
        return Ok(ApiResponse<IList<ActivityJoinRequestResponse>>.Ok(result));
    }

    [HttpGet("api/activity-requests/sent")]
    public async Task<IActionResult> GetSent()
    {
        var userId = User.GetUserId();
        var result = await _requestService.GetSentRequestsAsync(userId);
        return Ok(ApiResponse<IList<ActivityJoinRequestResponse>>.Ok(result));
    }

    [HttpGet("api/activity-requests/incoming")]
    public async Task<IActionResult> GetIncoming()
    {
        var userId = User.GetUserId();
        var result = await _requestService.GetIncomingRequestsAsync(userId);
        return Ok(ApiResponse<IList<ActivityJoinRequestResponse>>.Ok(result));
    }

    [HttpPost("api/activity-requests/{requestId:guid}/approve")]
    public async Task<IActionResult> Approve(Guid requestId)
    {
        var userId = User.GetUserId();
        await _requestService.ApproveAsync(requestId, userId);
        return Ok(ApiResponse<object>.Ok(null, "İstek onaylandı."));
    }

    [HttpPost("api/activity-requests/{requestId:guid}/reject")]
    public async Task<IActionResult> Reject(Guid requestId)
    {
        var userId = User.GetUserId();
        await _requestService.RejectAsync(requestId, userId);
        return Ok(ApiResponse<object>.Ok(null, "İstek reddedildi."));
    }

    [HttpPost("api/activity-requests/{requestId:guid}/cancel")]
    public async Task<IActionResult> Cancel(Guid requestId)
    {
        var userId = User.GetUserId();
        await _requestService.CancelAsync(requestId, userId);
        return Ok(ApiResponse<object>.Ok(null, "İstek iptal edildi."));
    }
}
