namespace Sosyolobi.Api.DTOs.Admin;

public class DashboardStatsResponse
{
    public int TotalUsers { get; set; }
    public int VerifiedUsers { get; set; }
    public int ActiveActivities { get; set; }
    public int TodayActivities { get; set; }
    public int PendingReports { get; set; }
    public double AverageRating { get; set; }

    public List<DailyCountItem> RegistrationsByDay { get; set; } = new();
    public List<DailyCountItem> ActivitiesByDay { get; set; } = new();
    public List<CategoryCountItem> CategoryDistribution { get; set; } = new();
}

public class DailyCountItem
{
    public string Date { get; set; } = null!;
    public int Count { get; set; }
}

public class CategoryCountItem
{
    public string CategoryName { get; set; } = null!;
    public int Count { get; set; }
}
