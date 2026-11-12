using Microsoft.AspNetCore.Mvc;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/geo")]
public class GeoController : ControllerBase
{
    private readonly IGeoService _geoService;

    public GeoController(IGeoService geoService) => _geoService = geoService;

    [HttpGet("reverse-geocode")]
    public async Task<IActionResult> ReverseGeocode([FromQuery] double lat, [FromQuery] double lng)
    {
        var result = await _geoService.ReverseGeocodeAsync(lat, lng);
        return Ok(ApiResponse<string?>.Ok(result));
    }

    [HttpGet("search-address")]
    public async Task<IActionResult> SearchAddress([FromQuery] string query)
    {
        var result = await _geoService.SearchAddressAsync(query);
        return Ok(ApiResponse<IList<string>>.Ok(result));
    }
}
