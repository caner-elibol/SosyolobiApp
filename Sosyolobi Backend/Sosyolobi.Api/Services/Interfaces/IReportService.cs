using Sosyolobi.Api.DTOs.Admin;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reports;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IReportService
{
    Task<ReportResponse> CreateAsync(Guid reporterUserId, CreateReportRequest request);
    Task<PagedResponse<ReportResponse>> GetMyReportsAsync(Guid reporterUserId, PagedRequest paged);
    Task<PagedResponse<ReportResponse>> GetAllAsync(AdminReportFilterRequest filter);
    Task<ReportResponse> GetByIdAsync(Guid reportId);
    Task ResolveAsync(Guid reportId);
    Task UpdateStatusAsync(Guid reportId, ReportStatus status, string? adminNote);
}
