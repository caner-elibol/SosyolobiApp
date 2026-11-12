namespace Sosyolobi.Api.Options;

public class GeoOptions
{
    public const string SectionName = "Geo";
    public int DefaultRadiusMeters { get; set; } = 5000;
    public int MaxRadiusMeters { get; set; } = 50000;
    public bool FuzzyLocationEnabled { get; set; } = false;
    public double FuzzyRadiusMeters { get; set; } = 100;
}
