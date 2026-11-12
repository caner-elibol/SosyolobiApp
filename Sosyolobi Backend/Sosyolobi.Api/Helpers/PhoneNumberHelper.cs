using System.Text.RegularExpressions;

namespace Sosyolobi.Api.Helpers;

public static class PhoneNumberHelper
{
    private static readonly Regex TurkishPhoneRegex = new(@"^(\+90|0090|90)?5\d{9}$", RegexOptions.Compiled);

    public static string Normalize(string phoneNumber)
    {
        var digits = Regex.Replace(phoneNumber, @"\D", "");

        if (digits.StartsWith("00"))
            digits = digits[2..];

        if (!digits.StartsWith("+"))
            digits = "+" + digits;

        if (digits.StartsWith("+905") && digits.Length == 13)
            return digits;

        if (digits.StartsWith("+5") && digits.Length == 11)
            return "+90" + digits[1..];

        if (digits.StartsWith("+905"))
            return digits;

        return digits;
    }

    public static bool IsValid(string phoneNumber)
    {
        var normalized = Normalize(phoneNumber);
        return normalized.StartsWith("+90") && normalized.Length == 13;
    }
}
