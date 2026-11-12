using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Activities;

public class ActivityDetailResponse : ActivityResponse
{
    public string? AddressDetailPrivate { get; set; }
    public IList<PublicProfileResponse> Participants { get; set; } = new List<PublicProfileResponse>();

    public ActivityRequestStatus? MyRequestStatus { get; set; }
}
