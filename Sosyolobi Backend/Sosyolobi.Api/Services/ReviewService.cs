using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Admin;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Reviews;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ReviewService : IReviewService
{
    private readonly AppDbContext _db;
    private readonly INotificationService _notifications;

    public ReviewService(AppDbContext db, INotificationService notifications)
    {
        _db = db;
        _notifications = notifications;
    }

    public async Task<ReviewResponse> CreateAsync(Guid reviewerUserId, CreateReviewRequest request)
    {
        if (request.Rating < 1 || request.Rating > 5)
            throw new ArgumentException("Puan 1-5 arasında olmalıdır.");

        if (reviewerUserId == request.ReviewedUserId)
            throw new InvalidOperationException("Kendinize yorum yapamazsınız.");

        var activity = await _db.Activities.FindAsync(request.ActivityId)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (activity.Status != ActivityStatus.Completed)
            throw new InvalidOperationException("Sadece tamamlanmış etkinlikler için yorum yapılabilir.");

        var isParticipant = await _db.ActivityParticipants
            .AnyAsync(p => p.ActivityId == request.ActivityId && p.UserId == reviewerUserId);
        if (!isParticipant)
            throw new InvalidOperationException("Bu etkinliğe katılmadınız.");

        var isReviewedParticipant = await _db.ActivityParticipants
            .AnyAsync(p => p.ActivityId == request.ActivityId && p.UserId == request.ReviewedUserId);
        if (!isReviewedParticipant)
            throw new InvalidOperationException("Yorum yapılan kullanıcı bu etkinliğe katılmadı.");

        var alreadyReviewed = await _db.Reviews
            .AnyAsync(r => r.ActivityId == request.ActivityId
                        && r.ReviewerUserId == reviewerUserId
                        && r.ReviewedUserId == request.ReviewedUserId);
        if (alreadyReviewed)
            throw new InvalidOperationException("Bu kullanıcıya zaten yorum yaptınız.");

        var review = new Review
        {
            Id = Guid.CreateVersion7(),
            ActivityId = request.ActivityId,
            ReviewerUserId = reviewerUserId,
            ReviewedUserId = request.ReviewedUserId,
            Rating = request.Rating,
            Comment = request.Comment,
            CreatedAt = DateTime.UtcNow
        };
        _db.Reviews.Add(review);

        var profile = await _db.UserProfiles.FirstOrDefaultAsync(p => p.UserId == request.ReviewedUserId);
        if (profile is not null)
        {
            var totalRating = profile.AverageRating * profile.ReviewCount + request.Rating;
            profile.ReviewCount++;
            profile.AverageRating = totalRating / profile.ReviewCount;
        }

        await _db.SaveChangesAsync();

        var reviewer = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == reviewerUserId);

        await _notifications.SendAsync(request.ReviewedUserId, NotificationType.NewReview,
            "Yeni bir yorum aldınız", request.Comment, request.ActivityId);

        return new ReviewResponse
        {
            Id = review.Id,
            ActivityId = review.ActivityId,
            ReviewerUserId = review.ReviewerUserId,
            ReviewerDisplayName = reviewer?.Profile?.DisplayName ?? string.Empty,
            ReviewerAvatarUrl = reviewer?.Profile?.AvatarUrl,
            Rating = review.Rating,
            Comment = review.Comment,
            CreatedAt = review.CreatedAt
        };
    }

    public async Task<PagedResponse<ReviewResponse>> GetUserReviewsAsync(Guid userId, PagedRequest paged)
    {
        var query = _db.Reviews
            .Include(r => r.ReviewerUser).ThenInclude(u => u.Profile)
            .Where(r => r.ReviewedUserId == userId)
            .OrderByDescending(r => r.CreatedAt);

        var total = await query.CountAsync();
        var items = await query.Skip((paged.Page - 1) * paged.PageSize).Take(paged.PageSize).ToListAsync();

        return new PagedResponse<ReviewResponse>
        {
            Items = items.Select(r => new ReviewResponse
            {
                Id = r.Id,
                ActivityId = r.ActivityId,
                ReviewerUserId = r.ReviewerUserId,
                ReviewerDisplayName = r.ReviewerUser.Profile?.DisplayName ?? string.Empty,
                ReviewerAvatarUrl = r.ReviewerUser.Profile?.AvatarUrl,
                Rating = r.Rating,
                Comment = r.Comment,
                CreatedAt = r.CreatedAt
            }).ToList(),
            TotalCount = total,
            Page = paged.Page,
            PageSize = paged.PageSize
        };
    }

    public async Task<PagedResponse<AdminReviewResponse>> GetAllAsync(PagedRequest paged)
    {
        var query = _db.Reviews
            .Include(r => r.ReviewerUser).ThenInclude(u => u.Profile)
            .Include(r => r.ReviewedUser).ThenInclude(u => u.Profile)
            .Include(r => r.Activity)
            .OrderByDescending(r => r.CreatedAt);

        var total = await query.CountAsync();
        var items = await query
            .Skip((paged.Page - 1) * paged.PageSize)
            .Take(paged.PageSize)
            .ToListAsync();

        return new PagedResponse<AdminReviewResponse>
        {
            Items = items.Select(r => new AdminReviewResponse
            {
                Id = r.Id,
                ActivityId = r.ActivityId,
                ActivityTitle = r.Activity?.Title ?? string.Empty,
                ReviewerUserId = r.ReviewerUserId,
                ReviewerDisplayName = r.ReviewerUser?.Profile?.DisplayName ?? string.Empty,
                ReviewerAvatarUrl = r.ReviewerUser?.Profile?.AvatarUrl,
                ReviewedUserId = r.ReviewedUserId,
                ReviewedDisplayName = r.ReviewedUser?.Profile?.DisplayName ?? string.Empty,
                Rating = r.Rating,
                Comment = r.Comment,
                IsHidden = r.IsHidden,
                CreatedAt = r.CreatedAt
            }).ToList(),
            TotalCount = total,
            Page = paged.Page,
            PageSize = paged.PageSize
        };
    }

    public async Task UpdateVisibilityAsync(Guid reviewId, bool isHidden)
    {
        var review = await _db.Reviews.FindAsync(reviewId)
            ?? throw new KeyNotFoundException("Yorum bulunamadı.");

        review.IsHidden = isHidden;
        await _db.SaveChangesAsync();
    }
}
