namespace Sosyolobi.Api.Services.Interfaces;

public interface IPexelsImageService
{
    Task<string?> GetCategoryImageAsync(string categoryName);
    Task<byte[]?> DownloadImageAsync(string imageUrl);
}
