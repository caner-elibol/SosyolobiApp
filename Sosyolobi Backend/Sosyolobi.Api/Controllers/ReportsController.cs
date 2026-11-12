using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reports;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/reports")]
[Authorize]
public class ReportsController : ControllerBase
{
    private readonly IReportService _reportService;

    public ReportsController(IReportService reportService) => _reportService = reportService;

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateReportRequest request)
    {
        var userId = User.GetUserId();
        var result = await _reportService.CreateAsync(userId, request);
        return Ok(ApiResponse<ReportResponse>.Ok(result));
    }

    [HttpGet("mine")]
    public async Task<IActionResult> GetMine([FromQuery] PagedRequest paged)
    {
        var userId = User.GetUserId();
        var result = await _reportService.GetMyReportsAsync(userId, paged);
        return Ok(ApiResponse<PagedResponse<ReportResponse>>.Ok(result));
    }
}
