using Sosyolobi.Api.DTOs.Admin;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reviews;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IReviewService
{
    Task<ReviewResponse> CreateAsync(Guid reviewerUserId, CreateReviewRequest request);
    Task<PagedResponse<ReviewResponse>> GetUserReviewsAsync(Guid userId, PagedRequest paged);
    Task<PagedResponse<AdminReviewResponse>> GetAllAsync(PagedRequest paged);
    Task UpdateVisibilityAsync(Guid reviewId, bool isHidden);
}
