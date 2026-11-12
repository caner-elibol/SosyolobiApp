using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class AdminActivityDetailResponse
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string? Description { get; set; }
    public string CategoryName { get; set; } = null!;
    public Guid CategoryId { get; set; }
    public DateTime EventDate { get; set; }
    public int NeededPeopleCount { get; set; }
    public int CurrentPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }
    public string SkillLevel { get; set; } = null!;
    public string GenderPreference { get; set; } = null!;
    public ActivityStatus Status { get; set; }
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public string AddressText { get; set; } = null!;
    public string? AddressDetailPrivate { get; set; }
    public DateTime CreatedAt { get; set; }

    public Guid CreatedByUserId { get; set; }
    public string CreatedByDisplayName { get; set; } = null!;
    public string? CreatedByAvatarUrl { get; set; }

    public List<AdminParticipantItem> Participants { get; set; } = new();
    public List<AdminJoinRequestItem> JoinRequests { get; set; } = new();
}

public class AdminParticipantItem
{
    public Guid UserId { get; set; }
    public string DisplayName { get; set; } = null!;
    public string? AvatarUrl { get; set; }
    public DateTime JoinedAt { get; set; }
}

public class AdminJoinRequestItem
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string DisplayName { get; set; } = null!;
    public string Status { get; set; } = null!;
    public DateTime RequestedAt { get; set; }
}
