using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.ActivityRequests;

public class ActivityJoinRequestResponse
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public PublicProfileResponse User { get; set; } = null!;
    public string? Message { get; set; }
    public ActivityRequestStatus Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? RespondedAt { get; set; }
}
