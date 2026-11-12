using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/activities")]
[Authorize]
public class ActivitiesController : ControllerBase
{
    private readonly IActivityService _activityService;

    public ActivitiesController(IActivityService activityService) => _activityService = activityService;

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateActivityRequest request)
    {
        var userId = User.GetUserId();
        var result = await _activityService.CreateAsync(userId, request);
        return CreatedAtAction(nameof(GetById), new { id = result.Id }, ApiResponse<ActivityResponse>.Ok(result));
    }

    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetList([FromQuery] PagedRequest paged)
    {
        var result = await _activityService.GetListAsync(paged);
        return Ok(ApiResponse<PagedResponse<ActivityResponse>>.Ok(result));
    }

    [HttpGet("nearby")]
    [AllowAnonymous]
    public async Task<IActionResult> GetNearby([FromQuery] NearbyActivitiesRequest request)
    {
        var result = await _activityService.GetNearbyAsync(request);
        return Ok(ApiResponse<IList<ActivityResponse>>.Ok(result));
    }

    [HttpGet("mine")]
    public async Task<IActionResult> GetMineUpcoming()
    {
        var userId = User.GetUserId();
        var result = await _activityService.GetMineUpcomingAsync(userId);
        return Ok(ApiResponse<IList<ActivityResponse>>.Ok(result));
    }

    [HttpGet("map")]
    [AllowAnonymous]
    public async Task<IActionResult> GetMap([FromQuery] NearbyActivitiesRequest request)
    {
        var result = await _activityService.GetMapItemsAsync(request);
        return Ok(ApiResponse<IList<ActivityMapItemResponse>>.Ok(result));
    }

    [HttpGet("map/paged")]
    [AllowAnonymous]
    public async Task<IActionResult> GetMapPaged([FromQuery] NearbyActivitiesRequest request, [FromQuery] PagedRequest paged)
    {
        var result = await _activityService.GetMapItemsPagedAsync(request, paged);
        return Ok(ApiResponse<PagedResponse<ActivityMapItemResponse>>.Ok(result));
    }

    [HttpGet("{id:guid}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetById(Guid id)
    {
        Guid? userId = User.Identity?.IsAuthenticated == true ? User.GetUserId() : null;
        var result = await _activityService.GetByIdAsync(id, userId);
        if (result is null) return NotFound();
        return Ok(ApiResponse<ActivityDetailResponse>.Ok(result));
    }

    [HttpPut("{id:guid}")]
    public async Task<IActionResult> Update(Guid id, [FromBody] UpdateActivityRequest request)
    {
        var userId = User.GetUserId();
        var result = await _activityService.UpdateAsync(id, userId, request);
        return Ok(ApiResponse<ActivityResponse>.Ok(result));
    }

    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var userId = User.GetUserId();
        await _activityService.DeleteAsync(id, userId);
        return NoContent();
    }

    [HttpPost("{id:guid}/cancel")]
    public async Task<IActionResult> Cancel(Guid id)
    {
        var userId = User.GetUserId();
        await _activityService.CancelAsync(id, userId);
        return Ok(ApiResponse<object>.Ok(null, "Etkinlik iptal edildi."));
    }

    [HttpPost("{id:guid}/complete")]
    public async Task<IActionResult> Complete(Guid id)
    {
        var userId = User.GetUserId();
        await _activityService.CompleteAsync(id, userId);
        return Ok(ApiResponse<object>.Ok(null, "Etkinlik tamamlandı."));
    }
}
