using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class AdminActivityFilterRequest : PagedRequest
{
    public string? Search { get; set; }
    public Guid? CategoryId { get; set; }
    public ActivityStatus? Status { get; set; }
}
