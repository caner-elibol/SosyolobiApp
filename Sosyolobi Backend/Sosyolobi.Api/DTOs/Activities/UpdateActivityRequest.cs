using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Activities;

public class UpdateActivityRequest
{
    public string? Title { get; set; }
    public string? Description { get; set; }
    public DateTime? EventDate { get; set; }
    public int? NeededPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }
    public SkillLevel? SkillLevel { get; set; }
    public GenderPreference? GenderPreference { get; set; }
    public string? AddressText { get; set; }
    public string? AddressDetailPrivate { get; set; }
}
