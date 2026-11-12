using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reviews;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api")]
[Authorize]
public class ReviewsController : ControllerBase
{
    private readonly IReviewService _reviewService;

    public ReviewsController(IReviewService reviewService) => _reviewService = reviewService;

    [HttpPost("reviews")]
    public async Task<IActionResult> Create([FromBody] CreateReviewRequest request)
    {
        var userId = User.GetUserId();
        var result = await _reviewService.CreateAsync(userId, request);
        return Ok(ApiResponse<ReviewResponse>.Ok(result));
    }

    [HttpGet("users/{userId:guid}/reviews")]
    [AllowAnonymous]
    public async Task<IActionResult> GetUserReviews(Guid userId, [FromQuery] PagedRequest paged)
    {
        var result = await _reviewService.GetUserReviewsAsync(userId, paged);
        return Ok(ApiResponse<PagedResponse<ReviewResponse>>.Ok(result));
    }
}
