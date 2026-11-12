namespace Sosyolobi.Api.Services.Interfaces;

public interface IGeoService
{
    Task<string?> ReverseGeocodeAsync(double latitude, double longitude);
    Task<IList<string>> SearchAddressAsync(string query);
}
