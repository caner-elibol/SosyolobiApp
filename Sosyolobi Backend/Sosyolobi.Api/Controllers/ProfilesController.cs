using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/profiles")]
[Authorize]
public class ProfilesController : ControllerBase
{
    private readonly IProfileService _profileService;

    public ProfilesController(IProfileService profileService) => _profileService = profileService;

    [HttpGet("me")]
    public async Task<IActionResult> GetMyProfile()
    {
        var userId = User.GetUserId();
        var result = await _profileService.GetMyProfileAsync(userId);
        if (result is null) return NotFound();
        return Ok(ApiResponse<ProfileResponse>.Ok(result));
    }

    [HttpPut("me")]
    public async Task<IActionResult> UpdateMyProfile([FromBody] UpdateProfileRequest request)
    {
        var userId = User.GetUserId();
        var result = await _profileService.UpdateProfileAsync(userId, request);
        return Ok(ApiResponse<ProfileResponse>.Ok(result));
    }

    public sealed class UploadAvatarRequest
    {
        public IFormFile File { get; set; } = default!;
    }

    [HttpPost("me/avatar")]
    [Consumes("multipart/form-data")]
    [RequestSizeLimit(5_000_000)]
    public async Task<IActionResult> UploadMyAvatar([FromForm] UploadAvatarRequest request)
    {
        var userId = User.GetUserId();
        var baseUrl = $"{Request.Scheme}://{Request.Host}";

        var result = await _profileService.UploadAvatarAsync(userId, request.File, baseUrl);

        return Ok(ApiResponse<ProfileResponse>.Ok(result));
    }

    [HttpGet("{userId:guid}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPublicProfile(Guid userId)
    {
        var result = await _profileService.GetMyProfileAsync(userId);
        if (result is null) return NotFound();
        return Ok(ApiResponse<PublicProfileResponse>.Ok(new PublicProfileResponse
        {
            UserId = result.UserId,
            DisplayName = result.DisplayName,
            Bio = result.Bio,
            AvatarUrl = result.AvatarUrl,
            AverageRating = result.AverageRating,
            ReviewCount = result.ReviewCount,
            CompletedActivityCount = result.CompletedActivityCount
        }));
    }
}
