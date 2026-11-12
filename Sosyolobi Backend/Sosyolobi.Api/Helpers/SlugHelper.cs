using System.Text;
using System.Text.RegularExpressions;

namespace Sosyolobi.Api.Helpers;

public static class SlugHelper
{
    private static readonly Dictionary<char, string> TurkishMap = new()
    {
        ['ç'] = "c", ['Ç'] = "c",
        ['ğ'] = "g", ['Ğ'] = "g",
        ['ı'] = "i", ['İ'] = "i",
        ['ö'] = "o", ['Ö'] = "o",
        ['ş'] = "s", ['Ş'] = "s",
        ['ü'] = "u", ['Ü'] = "u"
    };

    public static string Slugify(string text)
    {
        var sb = new StringBuilder();
        foreach (var c in text)
        {
            if (TurkishMap.TryGetValue(c, out var replacement))
                sb.Append(replacement);
            else
                sb.Append(c);
        }

        var result = sb.ToString().ToLowerInvariant();
        result = Regex.Replace(result, @"[^a-z0-9\s-]", "");
        result = Regex.Replace(result, @"\s+", "-");
        result = Regex.Replace(result, @"-+", "-").Trim('-');
        return result;
    }
}
