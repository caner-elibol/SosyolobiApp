using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class AdminUserFilterRequest : PagedRequest
{
    public string? Search { get; set; }
    public UserStatus? Status { get; set; }
    public bool? IsPhoneVerified { get; set; }
}
