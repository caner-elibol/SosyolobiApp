namespace Sosyolobi.Api.DTOs.Common;

public class ErrorResponse
{
    public string Message { get; set; } = null!;
    public string? Code { get; set; }
    public string? Detail { get; set; }
    public IDictionary<string, string[]>? Errors { get; set; }
}
