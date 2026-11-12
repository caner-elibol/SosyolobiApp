namespace Sosyolobi.Api.DTOs.Reports;

public class CreateReportRequest
{
    public Guid? ReportedUserId { get; set; }
    public Guid? ReportedActivityId { get; set; }
    public string Reason { get; set; } = null!;
    public string? Details { get; set; }
}
