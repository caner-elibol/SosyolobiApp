using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class GeoService : IGeoService
{
    private readonly ILogger<GeoService> _logger;

    public GeoService(ILogger<GeoService> logger) => _logger = logger;

    public Task<string?> ReverseGeocodeAsync(double latitude, double longitude)
    {
        // TODO: Nominatim veya Google Maps API entegrasyonu
        _logger.LogInformation("ReverseGeocode: {Lat}, {Lon}", latitude, longitude);
        return Task.FromResult<string?>(null);
    }

    public Task<IList<string>> SearchAddressAsync(string query)
    {
        // TODO: Nominatim veya Google Maps API entegrasyonu
        _logger.LogInformation("SearchAddress: {Query}", query);
        return Task.FromResult<IList<string>>(new List<string>());
    }
}
