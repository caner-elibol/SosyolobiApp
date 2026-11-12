using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Controllers;

[ApiController]
[Route("api/categories")]
public class CategoriesController : ControllerBase
{
    private static readonly TimeSpan ImageCacheDuration = TimeSpan.FromDays(30);

    private readonly AppDbContext _db;
    private readonly IPexelsImageService _pexelsImageService;
    private readonly IWebHostEnvironment _env;

    public CategoriesController(AppDbContext db, IPexelsImageService pexelsImageService, IWebHostEnvironment env)
    {
        _db = db;
        _pexelsImageService = pexelsImageService;
        _env = env;
    }

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var categories = await _db.ActivityCategories
            .Where(c => c.IsActive)
            .OrderBy(c => c.SortOrder)
            .ToListAsync();

        var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");

        var stale = categories
            .Where(c => !c.ImageIsCustom && (
                c.ImageUrl is null ||
                c.ImageFetchedAt is null ||
                c.ImageFetchedAt < DateTime.UtcNow - ImageCacheDuration ||
                !CategoryImageFileExists(c.ImageUrl, webRoot)))
            .ToList();

        if (stale.Count > 0)
        {
            var baseUrl = $"{Request.Scheme}://{Request.Host}";

            foreach (var category in stale)
            {
                var localUrl = await FetchAndStoreCategoryImageAsync(category.Name, category.Slug, baseUrl);
                if (localUrl is not null)
                {
                    category.ImageUrl = localUrl;
                    category.ImageFetchedAt = DateTime.UtcNow;
                }
            }

            await _db.SaveChangesAsync();
        }

        var result = categories.Select(c => new { c.Id, c.Name, c.Slug, c.IconName, c.Color, c.ImageUrl, c.SortOrder });

        return Ok(ApiResponse<object>.Ok(result));
    }

    private static bool CategoryImageFileExists(string? imageUrl, string webRoot)
    {
        var fileName = imageUrl?.Split('/').LastOrDefault();
        if (string.IsNullOrEmpty(fileName)) return false;
        return System.IO.File.Exists(Path.Combine(webRoot, "categories", fileName));
    }

    private async Task<string?> FetchAndStoreCategoryImageAsync(string categoryName, string categorySlug, string baseUrl)
    {
        var remoteUrl = await _pexelsImageService.GetCategoryImageAsync(categoryName);
        if (remoteUrl is null) return null;

        var bytes = await _pexelsImageService.DownloadImageAsync(remoteUrl);
        if (bytes is null || bytes.Length == 0) return null;

        var extension = Path.GetExtension(new Uri(remoteUrl).AbsolutePath);
        if (string.IsNullOrEmpty(extension)) extension = ".jpg";

        var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
        var categoriesDir = Path.Combine(webRoot, "categories");
        Directory.CreateDirectory(categoriesDir);

        var fileName = $"{categorySlug}{extension}";
        var filePath = Path.Combine(categoriesDir, fileName);
        await System.IO.File.WriteAllBytesAsync(filePath, bytes);

        return $"{baseUrl}/categories/{fileName}";
    }
}
