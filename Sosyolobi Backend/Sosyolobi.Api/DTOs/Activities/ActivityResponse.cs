using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Activities;

public class ActivityResponse
{
    public Guid Id { get; set; }
    public Guid CreatedByUserId { get; set; }
    public string CreatedByDisplayName { get; set; } = null!;
    public string? CreatedByAvatarUrl { get; set; }
    public Guid CategoryId { get; set; }
    public string CategoryName { get; set; } = null!;
    public string? CategoryImageUrl { get; set; }
    public string Title { get; set; } = null!;
    public string? Description { get; set; }
    public DateTime EventDate { get; set; }
    public int NeededPeopleCount { get; set; }
    public int CurrentPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }
    public SkillLevel SkillLevel { get; set; }
    public GenderPreference GenderPreference { get; set; }
    public ActivityStatus Status { get; set; }
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public string AddressText { get; set; } = null!;
    public double? DistanceMeters { get; set; }
    public DateTime CreatedAt { get; set; }
}
