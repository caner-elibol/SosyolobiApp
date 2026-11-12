using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Reports;

public class ReportResponse
{
    public Guid Id { get; set; }
    public Guid ReporterUserId { get; set; }
    public Guid? ReportedUserId { get; set; }
    public Guid? ReportedActivityId { get; set; }
    public string Reason { get; set; } = null!;
    public string? Details { get; set; }
    public ReportStatus Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? ResolvedAt { get; set; }
}
