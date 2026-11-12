using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Admin;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reports;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/admin")]
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly IAdminService _adminService;
    private readonly IReportService _reportService;
    private readonly IReviewService _reviewService;

    public AdminController(IAdminService adminService, IReportService reportService, IReviewService reviewService)
    {
        _adminService = adminService;
        _reportService = reportService;
        _reviewService = reviewService;
    }

    [HttpGet("dashboard/stats")]
    public async Task<IActionResult> GetDashboardStats()
    {
        var result = await _adminService.GetDashboardStatsAsync();
        return Ok(ApiResponse<DashboardStatsResponse>.Ok(result));
    }

    [HttpGet("users")]
    public async Task<IActionResult> GetUsers([FromQuery] AdminUserFilterRequest filter)
    {
        var result = await _adminService.GetUsersAsync(filter);
        return Ok(ApiResponse<PagedResponse<AdminUserListItem>>.Ok(result));
    }

    [HttpGet("users/{id:guid}")]
    public async Task<IActionResult> GetUser(Guid id)
    {
        var result = await _adminService.GetUserDetailAsync(id);
        return Ok(ApiResponse<AdminUserDetailResponse>.Ok(result));
    }

    [HttpPost("users/{id:guid}/suspend")]
    public async Task<IActionResult> Suspend(Guid id)
    {
        await _adminService.SuspendUserAsync(id);
        return Ok(ApiResponse<object>.Ok(null, "Kullanıcı askıya alındı."));
    }

    [HttpPost("users/{id:guid}/activate")]
    public async Task<IActionResult> Activate(Guid id)
    {
        await _adminService.ActivateUserAsync(id);
        return Ok(ApiResponse<object>.Ok(null, "Kullanıcı aktifleştirildi."));
    }

    [HttpPost("users/{id:guid}/ban")]
    public async Task<IActionResult> Ban(Guid id)
    {
        await _adminService.BanUserAsync(id);
        return Ok(ApiResponse<object>.Ok(null, "Kullanıcı banlandı."));
    }

    [HttpGet("activities")]
    public async Task<IActionResult> GetActivities([FromQuery] AdminActivityFilterRequest filter)
    {
        var result = await _adminService.GetActivitiesAsync(filter);
        return Ok(ApiResponse<PagedResponse<ActivityResponse>>.Ok(result));
    }

    [HttpGet("activities/{id:guid}")]
    public async Task<IActionResult> GetActivity(Guid id)
    {
        var result = await _adminService.GetActivityDetailAsync(id);
        return Ok(ApiResponse<AdminActivityDetailResponse>.Ok(result));
    }

    [HttpPatch("activities/{id:guid}/status")]
    public async Task<IActionResult> UpdateActivityStatus(Guid id, [FromBody] UpdateActivityStatusRequest request)
    {
        await _adminService.UpdateActivityStatusAsync(id, request.Status);
        return Ok(ApiResponse<object>.Ok(null, "Etkinlik durumu güncellendi."));
    }

    [HttpGet("reports")]
    public async Task<IActionResult> GetReports([FromQuery] AdminReportFilterRequest filter)
    {
        var result = await _reportService.GetAllAsync(filter);
        return Ok(ApiResponse<PagedResponse<ReportResponse>>.Ok(result));
    }

    [HttpGet("reports/{id:guid}")]
    public async Task<IActionResult> GetReport(Guid id)
    {
        var result = await _reportService.GetByIdAsync(id);
        return Ok(ApiResponse<ReportResponse>.Ok(result));
    }

    [HttpPatch("reports/{id:guid}/status")]
    public async Task<IActionResult> UpdateReportStatus(Guid id, [FromBody] UpdateReportStatusRequest request)
    {
        await _reportService.UpdateStatusAsync(id, request.Status, request.AdminNote);
        return Ok(ApiResponse<object>.Ok(null, "Rapor durumu güncellendi."));
    }

    [HttpPost("reports/{id:guid}/resolve")]
    public async Task<IActionResult> ResolveReport(Guid id)
    {
        await _reportService.ResolveAsync(id);
        return Ok(ApiResponse<object>.Ok(null, "Rapor çözüldü."));
    }

    [HttpGet("reviews")]
    public async Task<IActionResult> GetReviews([FromQuery] PagedRequest paged)
    {
        var result = await _reviewService.GetAllAsync(paged);
        return Ok(ApiResponse<PagedResponse<AdminReviewResponse>>.Ok(result));
    }

    [HttpPatch("reviews/{id:guid}/visibility")]
    public async Task<IActionResult> UpdateReviewVisibility(Guid id, [FromBody] UpdateReviewVisibilityRequest request)
    {
        await _reviewService.UpdateVisibilityAsync(id, request.IsHidden);
        return Ok(ApiResponse<object>.Ok(null, "Yorum görünürlüğü güncellendi."));
    }

    [HttpGet("categories")]
    public async Task<IActionResult> GetCategories()
    {
        var result = await _adminService.GetCategoriesAsync();
        return Ok(ApiResponse<List<AdminCategoryResponse>>.Ok(result));
    }

    [HttpPost("categories")]
    public async Task<IActionResult> CreateCategory([FromBody] AdminCategoryRequest request)
    {
        var result = await _adminService.CreateCategoryAsync(request);
        return CreatedAtAction(nameof(GetCategories), ApiResponse<AdminCategoryResponse>.Ok(result, "Kategori oluşturuldu."));
    }

    [HttpPut("categories/{id:guid}")]
    public async Task<IActionResult> UpdateCategory(Guid id, [FromBody] AdminCategoryRequest request)
    {
        await _adminService.UpdateCategoryAsync(id, request);
        return Ok(ApiResponse<object>.Ok(null, "Kategori güncellendi."));
    }

    [HttpPatch("categories/{id:guid}/status")]
    public async Task<IActionResult> UpdateCategoryStatus(Guid id, [FromBody] bool isActive)
    {
        await _adminService.UpdateCategoryStatusAsync(id, isActive);
        return Ok(ApiResponse<object>.Ok(null, "Kategori durumu güncellendi."));
    }

    public sealed class UploadCategoryImageRequest
    {
        public IFormFile File { get; set; } = default!;
    }

    [HttpPost("categories/{id:guid}/image")]
    [Consumes("multipart/form-data")]
    [RequestSizeLimit(5_000_000)]
    public async Task<IActionResult> UploadCategoryImage(Guid id, [FromForm] UploadCategoryImageRequest request)
    {
        var baseUrl = $"{Request.Scheme}://{Request.Host}";
        var result = await _adminService.UploadCategoryImageAsync(id, request.File, baseUrl);
        return Ok(ApiResponse<AdminCategoryResponse>.Ok(result, "Kategori resmi yüklendi."));
    }

    [HttpDelete("categories/{id:guid}/image")]
    public async Task<IActionResult> RemoveCategoryImage(Guid id)
    {
        var result = await _adminService.RemoveCategoryImageAsync(id);
        return Ok(ApiResponse<AdminCategoryResponse>.Ok(result, "Kategori resmi kaldırıldı."));
    }
}
