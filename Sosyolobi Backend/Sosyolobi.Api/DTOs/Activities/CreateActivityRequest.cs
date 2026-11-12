using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Activities;

public class CreateActivityRequest
{
    public Guid CategoryId { get; set; }
    public string Title { get; set; } = null!;
    public string? Description { get; set; }
    public DateTime EventDate { get; set; }
    public int NeededPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }
    public SkillLevel SkillLevel { get; set; } = SkillLevel.Any;
    public GenderPreference GenderPreference { get; set; } = GenderPreference.Any;
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public string AddressText { get; set; } = null!;
    public string? AddressDetailPrivate { get; set; }
}
