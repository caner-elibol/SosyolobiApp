using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Admin;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class AdminService : IAdminService
{
    private static readonly HashSet<string> AllowedImageContentTypes = new(StringComparer.OrdinalIgnoreCase)
    {
        "image/jpeg", "image/png", "image/webp"
    };
    private const long MaxCategoryImageSizeBytes = 5 * 1024 * 1024;

    private readonly AppDbContext _db;
    private readonly IWebHostEnvironment _env;

    public AdminService(AppDbContext db, IWebHostEnvironment env)
    {
        _db = db;
        _env = env;
    }

    public async Task<DashboardStatsResponse> GetDashboardStatsAsync()
    {
        var today = DateTime.UtcNow.Date;
        var sevenDaysAgo = today.AddDays(-6);

        var totalUsers = await _db.Users.CountAsync();
        var verifiedUsers = await _db.Users.CountAsync(u => u.IsPhoneVerified);
        var activeActivities = await _db.Activities.CountAsync(a => a.Status == ActivityStatus.Open);
        var todayActivities = await _db.Activities.CountAsync(a => a.EventDate.Date == today);
        var pendingReports = await _db.Reports.CountAsync(r => r.Status == ReportStatus.Pending);
        var avgRating = await _db.UserProfiles.AverageAsync(p => (double?)p.AverageRating) ?? 0;

        var registrationsByDay = await _db.Users
            .Where(u => u.CreatedAt.Date >= sevenDaysAgo)
            .GroupBy(u => u.CreatedAt.Date)
            .Select(g => new DailyCountItem { Date = g.Key.ToString("yyyy-MM-dd"), Count = g.Count() })
            .ToListAsync();

        var activitiesByDay = await _db.Activities
            .Where(a => a.CreatedAt.Date >= sevenDaysAgo)
            .GroupBy(a => a.CreatedAt.Date)
            .Select(g => new DailyCountItem { Date = g.Key.ToString("yyyy-MM-dd"), Count = g.Count() })
            .ToListAsync();

        var categoryDistribution = await _db.Activities
            .Where(a => a.Status == ActivityStatus.Open)
            .GroupBy(a => a.Category.Name)
            .Select(g => new CategoryCountItem { CategoryName = g.Key, Count = g.Count() })
            .ToListAsync();

        return new DashboardStatsResponse
        {
            TotalUsers = totalUsers,
            VerifiedUsers = verifiedUsers,
            ActiveActivities = activeActivities,
            TodayActivities = todayActivities,
            PendingReports = pendingReports,
            AverageRating = Math.Round(avgRating, 2),
            RegistrationsByDay = registrationsByDay,
            ActivitiesByDay = activitiesByDay,
            CategoryDistribution = categoryDistribution
        };
    }

    public async Task<PagedResponse<AdminUserListItem>> GetUsersAsync(AdminUserFilterRequest filter)
    {
        var query = _db.Users.Include(u => u.Profile).AsQueryable();

        if (!string.IsNullOrWhiteSpace(filter.Search))
        {
            var search = filter.Search.ToLower();
            query = query.Where(u =>
                u.PhoneNumber.Contains(search) ||
                (u.Email != null && u.Email.ToLower().Contains(search)) ||
                (u.Profile != null && u.Profile.DisplayName.ToLower().Contains(search)));
        }

        if (filter.Status.HasValue)
            query = query.Where(u => u.Status == filter.Status.Value);

        if (filter.IsPhoneVerified.HasValue)
            query = query.Where(u => u.IsPhoneVerified == filter.IsPhoneVerified.Value);

        query = query.OrderByDescending(u => u.CreatedAt);

        var total = await query.CountAsync();
        var items = await query
            .Skip((filter.Page - 1) * filter.PageSize)
            .Take(filter.PageSize)
            .ToListAsync();

        return new PagedResponse<AdminUserListItem>
        {
            Items = items.Select(u => new AdminUserListItem
            {
                Id = u.Id,
                PhoneNumber = u.PhoneNumber,
                IsPhoneVerified = u.IsPhoneVerified,
                Email = u.Email,
                Status = u.Status,
                CreatedAt = u.CreatedAt,
                LastLoginAt = u.LastLoginAt,
                DisplayName = u.Profile?.DisplayName ?? string.Empty,
                AvatarUrl = u.Profile?.AvatarUrl,
                AverageRating = u.Profile?.AverageRating ?? 0,
                ReviewCount = u.Profile?.ReviewCount ?? 0,
                CompletedActivityCount = u.Profile?.CompletedActivityCount ?? 0
            }).ToList(),
            TotalCount = total,
            Page = filter.Page,
            PageSize = filter.PageSize
        };
    }

    public async Task<AdminUserDetailResponse> GetUserDetailAsync(Guid userId)
    {
        var user = await _db.Users
            .Include(u => u.Profile)
            .FirstOrDefaultAsync(u => u.Id == userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        var reportCount = await _db.Reports.CountAsync(r =>
            r.ReportedUserId == userId && r.Status != ReportStatus.Dismissed);

        var createdActivityCount = await _db.Activities.CountAsync(a => a.CreatedByUserId == userId);

        var recentActivities = await _db.Activities
            .Include(a => a.Category)
            .Where(a => a.CreatedByUserId == userId)
            .OrderByDescending(a => a.CreatedAt)
            .Take(5)
            .Select(a => new AdminUserActivityItem
            {
                Id = a.Id,
                Title = a.Title,
                CategoryName = a.Category.Name,
                EventDate = a.EventDate,
                Status = a.Status.ToString()
            })
            .ToListAsync();

        var recentReports = await _db.Reports
            .Where(r => r.ReportedUserId == userId)
            .OrderByDescending(r => r.CreatedAt)
            .Take(5)
            .Select(r => new AdminUserReportItem
            {
                Id = r.Id,
                Reason = r.Reason,
                Status = r.Status.ToString(),
                CreatedAt = r.CreatedAt
            })
            .ToListAsync();

        return new AdminUserDetailResponse
        {
            Id = user.Id,
            PhoneNumber = user.PhoneNumber,
            IsPhoneVerified = user.IsPhoneVerified,
            Email = user.Email,
            Status = user.Status,
            CreatedAt = user.CreatedAt,
            LastLoginAt = user.LastLoginAt,
            DisplayName = user.Profile?.DisplayName ?? string.Empty,
            Bio = user.Profile?.Bio,
            AvatarUrl = user.Profile?.AvatarUrl,
            AverageRating = user.Profile?.AverageRating ?? 0,
            ReviewCount = user.Profile?.ReviewCount ?? 0,
            CompletedActivityCount = user.Profile?.CompletedActivityCount ?? 0,
            ReportCount = reportCount,
            CreatedActivityCount = createdActivityCount,
            RecentActivities = recentActivities,
            RecentReports = recentReports
        };
    }

    public async Task SuspendUserAsync(Guid userId)
    {
        var user = await _db.Users.FindAsync(userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        user.Status = UserStatus.Suspended;
        await _db.SaveChangesAsync();
    }

    public async Task ActivateUserAsync(Guid userId)
    {
        var user = await _db.Users.FindAsync(userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        user.Status = UserStatus.Active;
        await _db.SaveChangesAsync();
    }

    public async Task BanUserAsync(Guid userId)
    {
        var user = await _db.Users.FindAsync(userId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        user.Status = UserStatus.Banned;
        await _db.SaveChangesAsync();
    }

    public async Task<PagedResponse<ActivityResponse>> GetActivitiesAsync(AdminActivityFilterRequest filter)
    {
        var query = _db.Activities
            .Include(a => a.Category)
            .Include(a => a.CreatedByUser).ThenInclude(u => u.Profile)
            .AsQueryable();

        if (!string.IsNullOrWhiteSpace(filter.Search))
        {
            var search = filter.Search.ToLower();
            query = query.Where(a => a.Title.ToLower().Contains(search) ||
                                     a.AddressText.ToLower().Contains(search));
        }

        if (filter.CategoryId.HasValue)
            query = query.Where(a => a.CategoryId == filter.CategoryId.Value);

        if (filter.Status.HasValue)
            query = query.Where(a => a.Status == filter.Status.Value);

        query = query.OrderByDescending(a => a.CreatedAt);

        var total = await query.CountAsync();
        var items = await query
            .Skip((filter.Page - 1) * filter.PageSize)
            .Take(filter.PageSize)
            .ToListAsync();

        return new PagedResponse<ActivityResponse>
        {
            Items = items.Select(a => new ActivityResponse
            {
                Id = a.Id,
                CreatedByUserId = a.CreatedByUserId,
                CreatedByDisplayName = a.CreatedByUser?.Profile?.DisplayName ?? string.Empty,
                CategoryId = a.CategoryId,
                CategoryName = a.Category?.Name ?? string.Empty,
                Title = a.Title,
                EventDate = a.EventDate,
                NeededPeopleCount = a.NeededPeopleCount,
                CurrentPeopleCount = a.CurrentPeopleCount,
                Status = a.Status,
                Latitude = a.Location.Y,
                Longitude = a.Location.X,
                AddressText = a.AddressText,
                CreatedAt = a.CreatedAt
            }).ToList(),
            TotalCount = total,
            Page = filter.Page,
            PageSize = filter.PageSize
        };
    }

    public async Task<AdminActivityDetailResponse> GetActivityDetailAsync(Guid activityId)
    {
        var activity = await _db.Activities
            .Include(a => a.Category)
            .Include(a => a.CreatedByUser).ThenInclude(u => u.Profile)
            .FirstOrDefaultAsync(a => a.Id == activityId)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        var participants = await _db.ActivityParticipants
            .Include(p => p.User).ThenInclude(u => u.Profile)
            .Where(p => p.ActivityId == activityId)
            .Select(p => new AdminParticipantItem
            {
                UserId = p.UserId,
                DisplayName = p.User.Profile != null ? p.User.Profile.DisplayName : string.Empty,
                AvatarUrl = p.User.Profile != null ? p.User.Profile.AvatarUrl : null,
                JoinedAt = p.JoinedAt
            })
            .ToListAsync();

        var joinRequests = await _db.ActivityRequests
            .Include(r => r.User).ThenInclude(u => u.Profile)
            .Where(r => r.ActivityId == activityId)
            .Select(r => new AdminJoinRequestItem
            {
                Id = r.Id,
                UserId = r.UserId,
                DisplayName = r.User.Profile != null ? r.User.Profile.DisplayName : string.Empty,
                Status = r.Status.ToString(),
                RequestedAt = r.CreatedAt
            })
            .ToListAsync();

        return new AdminActivityDetailResponse
        {
            Id = activity.Id,
            Title = activity.Title,
            Description = activity.Description,
            CategoryId = activity.CategoryId,
            CategoryName = activity.Category?.Name ?? string.Empty,
            EventDate = activity.EventDate,
            NeededPeopleCount = activity.NeededPeopleCount,
            CurrentPeopleCount = activity.CurrentPeopleCount,
            PricePerPerson = activity.PricePerPerson,
            SkillLevel = activity.SkillLevel.ToString(),
            GenderPreference = activity.GenderPreference.ToString(),
            Status = activity.Status,
            Latitude = activity.Location.Y,
            Longitude = activity.Location.X,
            AddressText = activity.AddressText,
            AddressDetailPrivate = activity.AddressDetailPrivate,
            CreatedAt = activity.CreatedAt,
            CreatedByUserId = activity.CreatedByUserId,
            CreatedByDisplayName = activity.CreatedByUser?.Profile?.DisplayName ?? string.Empty,
            CreatedByAvatarUrl = activity.CreatedByUser?.Profile?.AvatarUrl,
            Participants = participants,
            JoinRequests = joinRequests
        };
    }

    public async Task UpdateActivityStatusAsync(Guid activityId, ActivityStatus status)
    {
        var activity = await _db.Activities.FindAsync(activityId)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        activity.Status = status;
        activity.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
    }

    public async Task<List<AdminCategoryResponse>> GetCategoriesAsync()
    {
        return await _db.ActivityCategories
            .OrderBy(c => c.SortOrder)
            .Select(c => new AdminCategoryResponse
            {
                Id = c.Id,
                Name = c.Name,
                Slug = c.Slug,
                IconName = c.IconName,
                Color = c.Color,
                SortOrder = c.SortOrder,
                IsActive = c.IsActive,
                ActivityCount = c.Activities.Count,
                ImageUrl = c.ImageUrl,
                ImageIsCustom = c.ImageIsCustom
            })
            .ToListAsync();
    }

    public async Task<AdminCategoryResponse> CreateCategoryAsync(AdminCategoryRequest request)
    {
        var category = new ActivityCategory
        {
            Id = Guid.CreateVersion7(),
            Name = request.Name,
            Slug = request.Slug,
            IconName = request.IconName,
            Color = request.Color,
            SortOrder = request.SortOrder,
            IsActive = request.IsActive
        };
        _db.ActivityCategories.Add(category);
        await _db.SaveChangesAsync();

        return new AdminCategoryResponse
        {
            Id = category.Id,
            Name = category.Name,
            Slug = category.Slug,
            IconName = category.IconName,
            Color = category.Color,
            SortOrder = category.SortOrder,
            IsActive = category.IsActive,
            ActivityCount = 0,
            ImageUrl = null,
            ImageIsCustom = false
        };
    }

    public async Task UpdateCategoryAsync(Guid categoryId, AdminCategoryRequest request)
    {
        var category = await _db.ActivityCategories.FindAsync(categoryId)
            ?? throw new KeyNotFoundException("Kategori bulunamadı.");

        category.Name = request.Name;
        category.Slug = request.Slug;
        category.IconName = request.IconName;
        category.Color = request.Color;
        category.SortOrder = request.SortOrder;
        category.IsActive = request.IsActive;
        await _db.SaveChangesAsync();
    }

    public async Task UpdateCategoryStatusAsync(Guid categoryId, bool isActive)
    {
        var category = await _db.ActivityCategories.FindAsync(categoryId)
            ?? throw new KeyNotFoundException("Kategori bulunamadı.");

        category.IsActive = isActive;
        await _db.SaveChangesAsync();
    }

    public async Task<AdminCategoryResponse> UploadCategoryImageAsync(Guid categoryId, IFormFile file, string baseUrl)
    {
        if (file.Length == 0)
            throw new ArgumentException("Dosya boş.");
        if (file.Length > MaxCategoryImageSizeBytes)
            throw new ArgumentException("Dosya boyutu 5 MB'ı aşamaz.");
        if (!AllowedImageContentTypes.Contains(file.ContentType))
            throw new ArgumentException("Sadece JPEG, PNG veya WEBP yüklenebilir.");

        var category = await _db.ActivityCategories.FindAsync(categoryId)
            ?? throw new KeyNotFoundException("Kategori bulunamadı.");

        var extension = file.ContentType switch
        {
            "image/jpeg" => ".jpg",
            "image/png" => ".png",
            "image/webp" => ".webp",
            _ => ".jpg"
        };
        var fileName = $"{Guid.CreateVersion7()}{extension}";
        var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
        var categoriesDir = Path.Combine(webRoot, "categories");
        Directory.CreateDirectory(categoriesDir);
        var filePath = Path.Combine(categoriesDir, fileName);

        using (var stream = new FileStream(filePath, FileMode.Create))
            await file.CopyToAsync(stream);

        category.ImageUrl = $"{baseUrl}/categories/{fileName}";
        category.ImageFetchedAt = DateTime.UtcNow;
        category.ImageIsCustom = true;
        await _db.SaveChangesAsync();

        return new AdminCategoryResponse
        {
            Id = category.Id,
            Name = category.Name,
            Slug = category.Slug,
            IconName = category.IconName,
            Color = category.Color,
            SortOrder = category.SortOrder,
            IsActive = category.IsActive,
            ActivityCount = await _db.Activities.CountAsync(a => a.CategoryId == category.Id),
            ImageUrl = category.ImageUrl,
            ImageIsCustom = category.ImageIsCustom
        };
    }

    public async Task<AdminCategoryResponse> RemoveCategoryImageAsync(Guid categoryId)
    {
        var category = await _db.ActivityCategories.FindAsync(categoryId)
            ?? throw new KeyNotFoundException("Kategori bulunamadı.");

        category.ImageUrl = null;
        category.ImageFetchedAt = null;
        category.ImageIsCustom = false;
        await _db.SaveChangesAsync();

        return new AdminCategoryResponse
        {
            Id = category.Id,
            Name = category.Name,
            Slug = category.Slug,
            IconName = category.IconName,
            Color = category.Color,
            SortOrder = category.SortOrder,
            IsActive = category.IsActive,
            ActivityCount = await _db.Activities.CountAsync(a => a.CategoryId == category.Id),
            ImageUrl = null,
            ImageIsCustom = false
        };
    }
}
