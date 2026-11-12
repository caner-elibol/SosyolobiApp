using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Activities;

public class NearbyActivitiesRequest
{
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public int RadiusMeters { get; set; } = 5000;
    public Guid? CategoryId { get; set; }
    public DateTime? FromDate { get; set; }
    public DateTime? ToDate { get; set; }
    public GenderPreference? GenderPreference { get; set; }
    public bool? IsFree { get; set; }
}
