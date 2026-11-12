using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Admin;

public class AdminUserDetailResponse
{
    public Guid Id { get; set; }
    public string PhoneNumber { get; set; } = null!;
    public bool IsPhoneVerified { get; set; }
    public string? Email { get; set; }
    public UserStatus Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? LastLoginAt { get; set; }

    public string DisplayName { get; set; } = null!;
    public string? Bio { get; set; }
    public string? AvatarUrl { get; set; }
    public double AverageRating { get; set; }
    public int ReviewCount { get; set; }
    public int CompletedActivityCount { get; set; }

    public int ReportCount { get; set; }
    public int CreatedActivityCount { get; set; }

    public List<AdminUserActivityItem> RecentActivities { get; set; } = new();
    public List<AdminUserReportItem> RecentReports { get; set; } = new();
}

public class AdminUserActivityItem
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string CategoryName { get; set; } = null!;
    public DateTime EventDate { get; set; }
    public string Status { get; set; } = null!;
}

public class AdminUserReportItem
{
    public Guid Id { get; set; }
    public string Reason { get; set; } = null!;
    public string Status { get; set; } = null!;
    public DateTime CreatedAt { get; set; }
}
