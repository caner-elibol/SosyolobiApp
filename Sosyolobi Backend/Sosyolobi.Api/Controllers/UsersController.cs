using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/users")]
[Authorize]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;

    public UsersController(IUserService userService) => _userService = userService;

    [HttpGet("{userId:guid}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPublicProfile(Guid userId)
    {
        var result = await _userService.GetPublicProfileAsync(userId);
        if (result is null) return NotFound();
        return Ok(ApiResponse<PublicProfileResponse>.Ok(result));
    }

    [HttpPost("{userId:guid}/block")]
    public async Task<IActionResult> Block(Guid userId)
    {
        var blockerId = User.GetUserId();
        await _userService.BlockUserAsync(blockerId, userId);
        return Ok(ApiResponse<object>.Ok(null, "Kullanıcı engellendi."));
    }

    [HttpDelete("{userId:guid}/block")]
    public async Task<IActionResult> Unblock(Guid userId)
    {
        var blockerId = User.GetUserId();
        await _userService.UnblockUserAsync(blockerId, userId);
        return Ok(ApiResponse<object>.Ok(null, "Engel kaldırıldı."));
    }
}
