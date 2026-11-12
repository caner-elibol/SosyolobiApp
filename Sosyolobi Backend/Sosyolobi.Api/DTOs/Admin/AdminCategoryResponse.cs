namespace Sosyolobi.Api.DTOs.Admin;

public class AdminCategoryResponse
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string Slug { get; set; } = null!;
    public string? IconName { get; set; }
    public string? Color { get; set; }
    public int SortOrder { get; set; }
    public bool IsActive { get; set; }
    public int ActivityCount { get; set; }
    public string? ImageUrl { get; set; }
    public bool ImageIsCustom { get; set; }
}
