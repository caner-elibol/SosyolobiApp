using System.Net.Http.Json;
using System.Text.Json.Serialization;
using Microsoft.Extensions.Options;
using Sosyolobi.Api.Options;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class PexelsImageService : IPexelsImageService
{
    private static readonly Dictionary<string, string> CategorySearchTerms = new()
    {
        ["Futbol"] = "football match",
        ["Basketbol"] = "basketball game",
        ["Voleybol"] = "volleyball game",
        ["Tenis"] = "tennis court",
        ["Koşu"] = "people running",
        ["Bisiklet"] = "cycling group",
        ["Yürüyüş"] = "hiking trail",
        ["Kamp"] = "camping tent nature",
        ["Kayak"] = "skiing snow",
        ["Masa Oyunu"] = "board game friends",
        ["Konser"] = "concert crowd",
        ["Kahve & Sosyal Buluşma"] = "friends coffee",
        ["Diğer"] = "friends outdoor",
    };

    private readonly HttpClient _http;
    private readonly PexelsOptions _options;
    private readonly ILogger<PexelsImageService> _logger;

    public PexelsImageService(HttpClient http, IOptions<PexelsOptions> options, ILogger<PexelsImageService> logger)
    {
        _http = http;
        _options = options.Value;
        _logger = logger;
    }

    public async Task<string?> GetCategoryImageAsync(string categoryName)
    {
        if (string.IsNullOrWhiteSpace(_options.ApiKey))
            return null;

        var query = CategorySearchTerms.TryGetValue(categoryName, out var term) ? term : categoryName;

        try
        {
            using var request = new HttpRequestMessage(
                HttpMethod.Get,
                $"search?query={Uri.EscapeDataString(query)}&per_page=7&orientation=landscape");
            request.Headers.Add("Authorization", _options.ApiKey);

            using var response = await _http.SendAsync(request);
            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Pexels request failed for {Category}: {Status}", categoryName, response.StatusCode);
                return null;
            }

            var result = await response.Content.ReadFromJsonAsync<PexelsSearchResponse>();
            var photos = result?.Photos;
            if (photos is null || photos.Count == 0) return null;

            var photo = photos[Random.Shared.Next(photos.Count)];
            return photo.Src?.Landscape ?? photo.Src?.Large;
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Pexels image fetch error for {Category}", categoryName);
            return null;
        }
    }

    public async Task<byte[]?> DownloadImageAsync(string imageUrl)
    {
        try
        {
            return await _http.GetByteArrayAsync(imageUrl);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Pexels image download error for {Url}", imageUrl);
            return null;
        }
    }

    private class PexelsSearchResponse
    {
        [JsonPropertyName("photos")]
        public List<PexelsPhoto>? Photos { get; set; }
    }

    private class PexelsPhoto
    {
        [JsonPropertyName("src")]
        public PexelsPhotoSrc? Src { get; set; }
    }

    private class PexelsPhotoSrc
    {
        [JsonPropertyName("landscape")]
        public string? Landscape { get; set; }

        [JsonPropertyName("large")]
        public string? Large { get; set; }
    }
}
