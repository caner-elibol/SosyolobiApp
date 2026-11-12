using Microsoft.AspNetCore.Http;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Admin;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IAdminService
{
    Task<DashboardStatsResponse> GetDashboardStatsAsync();

    Task<PagedResponse<AdminUserListItem>> GetUsersAsync(AdminUserFilterRequest filter);
    Task<AdminUserDetailResponse> GetUserDetailAsync(Guid userId);
    Task SuspendUserAsync(Guid userId);
    Task ActivateUserAsync(Guid userId);
    Task BanUserAsync(Guid userId);

    Task<PagedResponse<ActivityResponse>> GetActivitiesAsync(AdminActivityFilterRequest filter);
    Task<AdminActivityDetailResponse> GetActivityDetailAsync(Guid activityId);
    Task UpdateActivityStatusAsync(Guid activityId, ActivityStatus status);

    Task<List<AdminCategoryResponse>> GetCategoriesAsync();
    Task<AdminCategoryResponse> CreateCategoryAsync(AdminCategoryRequest request);
    Task UpdateCategoryAsync(Guid categoryId, AdminCategoryRequest request);
    Task UpdateCategoryStatusAsync(Guid categoryId, bool isActive);
    Task<AdminCategoryResponse> UploadCategoryImageAsync(Guid categoryId, IFormFile file, string baseUrl);
    Task<AdminCategoryResponse> RemoveCategoryImageAsync(Guid categoryId);
}
