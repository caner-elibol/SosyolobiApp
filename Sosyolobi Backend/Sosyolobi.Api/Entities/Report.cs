using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Entities;

public class Report
{
    public Guid Id { get; set; }
    public Guid ReporterUserId { get; set; }
    public Guid? ReportedUserId { get; set; }
    public Guid? ReportedActivityId { get; set; }
    public string Reason { get; set; } = null!;
    public string? Details { get; set; }
    public ReportStatus Status { get; set; } = ReportStatus.Pending;
    public DateTime CreatedAt { get; set; }
    public DateTime? ResolvedAt { get; set; }

    public User ReporterUser { get; set; } = null!;
    public User? ReportedUser { get; set; }
    public Activity? ReportedActivity { get; set; }
}
