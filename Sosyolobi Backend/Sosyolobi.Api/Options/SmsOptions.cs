namespace Sosyolobi.Api.Options;

public class SmsOptions
{
    public const string SectionName = "Sms";
    public bool DevelopmentMode { get; set; } = true;
    public string? DevelopmentFixedCode { get; set; } = "123456";
    public string? ApiKey { get; set; }
    public string? Sender { get; set; }
}
