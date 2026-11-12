using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class AdminReportFilterRequest : PagedRequest
{
    public ReportStatus? Status { get; set; }
}
