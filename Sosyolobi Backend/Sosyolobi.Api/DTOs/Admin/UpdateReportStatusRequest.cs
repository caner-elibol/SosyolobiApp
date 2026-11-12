using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class UpdateReportStatusRequest
{
    public ReportStatus Status { get; set; }
    public string? AdminNote { get; set; }
}
