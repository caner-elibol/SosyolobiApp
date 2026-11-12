namespace Sosyolobi.Api.DTOs.Profiles;

public class UpdateProfileRequest
{
    public string DisplayName { get; set; } = null!;
    public string? Bio { get; set; }
    public string? AvatarUrl { get; set; }
    public DateTime? BirthDate { get; set; }
}
