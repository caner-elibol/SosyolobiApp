namespace Sosyolobi.Api.Entities;

public class ActivityCategory
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string Slug { get; set; } = null!;
    public string? IconName { get; set; }
    public string? Color { get; set; }
    public string? ImageUrl { get; set; }
    public DateTime? ImageFetchedAt { get; set; }
    public bool ImageIsCustom { get; set; }
    public bool IsActive { get; set; } = true;
    public int SortOrder { get; set; }

    public ICollection<Activity> Activities { get; set; } = new List<Activity>();
}
