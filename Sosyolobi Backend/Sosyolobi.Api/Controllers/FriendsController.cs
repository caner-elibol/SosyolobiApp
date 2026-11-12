using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Friends;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/friends")]
[Authorize]
public class FriendsController : ControllerBase
{
    private readonly IFriendService _friendService;

    public FriendsController(IFriendService friendService) => _friendService = friendService;

    [HttpGet]
    public async Task<IActionResult> GetFriends()
    {
        var userId = User.GetUserId();
        var result = await _friendService.GetFriendsAsync(userId);
        return Ok(ApiResponse<IList<FriendResponse>>.Ok(result));
    }

    [HttpDelete("{friendUserId:guid}")]
    public async Task<IActionResult> RemoveFriend(Guid friendUserId)
    {
        var userId = User.GetUserId();
        await _friendService.RemoveFriendAsync(friendUserId, userId);
        return Ok(ApiResponse<object>.Ok(null, "Arkadaşlıktan çıkarıldı."));
    }

    [HttpGet("{friendUserId:guid}/activities")]
    public async Task<IActionResult> GetFriendActivities(Guid friendUserId)
    {
        var userId = User.GetUserId();
        var result = await _friendService.GetFriendActivitiesAsync(friendUserId, userId);
        return Ok(ApiResponse<IList<ActivityResponse>>.Ok(result));
    }

    [HttpPost("requests")]
    public async Task<IActionResult> SendRequest([FromBody] SendFriendRequestRequest request)
    {
        var userId = User.GetUserId();
        var result = await _friendService.SendRequestAsync(userId, request.AddresseeUserId);
        return Ok(ApiResponse<FriendRequestResponse>.Ok(result));
    }

    [HttpGet("requests/incoming")]
    public async Task<IActionResult> GetIncomingRequests()
    {
        var userId = User.GetUserId();
        var result = await _friendService.GetIncomingRequestsAsync(userId);
        return Ok(ApiResponse<IList<FriendRequestResponse>>.Ok(result));
    }

    [HttpGet("requests/sent")]
    public async Task<IActionResult> GetSentRequests()
    {
        var userId = User.GetUserId();
        var result = await _friendService.GetSentRequestsAsync(userId);
        return Ok(ApiResponse<IList<FriendRequestResponse>>.Ok(result));
    }

    [HttpPost("requests/{id:guid}/accept")]
    public async Task<IActionResult> Accept(Guid id)
    {
        var userId = User.GetUserId();
        await _friendService.AcceptAsync(id, userId);
        return Ok(ApiResponse<object>.Ok(null, "Arkadaşlık isteği kabul edildi."));
    }

    [HttpPost("requests/{id:guid}/reject")]
    public async Task<IActionResult> Reject(Guid id)
    {
        var userId = User.GetUserId();
        await _friendService.RejectAsync(id, userId);
        return Ok(ApiResponse<object>.Ok(null, "Arkadaşlık isteği reddedildi."));
    }

    [HttpDelete("requests/{id:guid}")]
    public async Task<IActionResult> Cancel(Guid id)
    {
        var userId = User.GetUserId();
        await _friendService.CancelAsync(id, userId);
        return Ok(ApiResponse<object>.Ok(null, "Arkadaşlık isteği iptal edildi."));
    }
}
