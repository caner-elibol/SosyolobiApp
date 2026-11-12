using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Activities;

public class ActivityMapItemResponse
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string CategoryName { get; set; } = null!;
    public string? CategoryImageUrl { get; set; }
    public ActivityStatus Status { get; set; }
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public DateTime EventDate { get; set; }
    public int NeededPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }
    public double DistanceMeters { get; set; }
}
