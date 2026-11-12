namespace Sosyolobi.Api.DTOs.Auth;

public class AdminLoginRequest
{
    public string PhoneNumber { get; set; } = null!;
    public string Password { get; set; } = null!;
}
