using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.ActivityRequests;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ActivityRequestService : IActivityRequestService
{
    private readonly AppDbContext _db;
    private readonly INotificationService _notifications;

    public ActivityRequestService(AppDbContext db, INotificationService notifications)
    {
        _db = db;
        _notifications = notifications;
    }

    public async Task<ActivityJoinRequestResponse> JoinAsync(Guid activityId, Guid userId, JoinActivityRequest request)
    {
        var activity = await _db.Activities.FindAsync(activityId)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (activity.Status != ActivityStatus.Open)
            throw new InvalidOperationException("Etkinlik katılıma kapalı.");

        if (activity.CreatedByUserId == userId)
            throw new InvalidOperationException("Kendi etkinliğinize katılım isteği gönderemezsiniz.");

        var alreadyRequested = await _db.ActivityRequests
            .AnyAsync(r => r.ActivityId == activityId && r.UserId == userId);
        if (alreadyRequested)
            throw new InvalidOperationException("Zaten katılım isteği gönderildi.");

        var entity = new ActivityRequest
        {
            Id = Guid.CreateVersion7(),
            ActivityId = activityId,
            UserId = userId,
            Message = request.Message,
            Status = ActivityRequestStatus.Pending,
            CreatedAt = DateTime.UtcNow
        };
        _db.ActivityRequests.Add(entity);
        await _db.SaveChangesAsync();

        await _notifications.SendAsync(activity.CreatedByUserId, NotificationType.ActivityRequest,
            "Yeni katılım isteği", request.Message, activityId);

        var user = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == userId);
        return MapToResponse(entity, user);
    }

    public async Task<IList<ActivityJoinRequestResponse>> GetRequestsAsync(Guid activityId, Guid requestingUserId)
    {
        var activity = await _db.Activities.FindAsync(activityId)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (activity.CreatedByUserId != requestingUserId)
            throw new UnauthorizedAccessException("Bu istekleri görüntüleyemezsiniz.");

        var requests = await _db.ActivityRequests
            .Include(r => r.User).ThenInclude(u => u.Profile)
            .Where(r => r.ActivityId == activityId)
            .OrderByDescending(r => r.CreatedAt)
            .ToListAsync();

        return requests.Select(r => MapToResponse(r, r.User)).ToList();
    }

    public async Task<IList<ActivityJoinRequestResponse>> GetSentRequestsAsync(Guid userId)
    {
        var requests = await _db.ActivityRequests
            .Include(r => r.User).ThenInclude(u => u.Profile)
            .Where(r => r.UserId == userId)
            .OrderByDescending(r => r.CreatedAt)
            .ToListAsync();

        return requests.Select(r => MapToResponse(r, r.User)).ToList();
    }

    public async Task<IList<ActivityJoinRequestResponse>> GetIncomingRequestsAsync(Guid userId)
    {
        var requests = await _db.ActivityRequests
            .Include(r => r.User).ThenInclude(u => u.Profile)
            .Include(r => r.Activity)
            .Where(r => r.Activity.CreatedByUserId == userId)
            .OrderByDescending(r => r.CreatedAt)
            .ToListAsync();

        return requests.Select(r => MapToResponse(r, r.User)).ToList();
    }

    public async Task ApproveAsync(Guid requestId, Guid userId)
    {
        var request = await _db.ActivityRequests.Include(r => r.Activity)
            .FirstOrDefaultAsync(r => r.Id == requestId)
            ?? throw new KeyNotFoundException("İstek bulunamadı.");

        if (request.Activity.CreatedByUserId != userId)
            throw new UnauthorizedAccessException("Bu isteği onaylayamazsınız.");

        if (request.Status != ActivityRequestStatus.Pending)
            throw new InvalidOperationException("İstek zaten yanıtlandı.");

        request.Status = ActivityRequestStatus.Approved;
        request.RespondedAt = DateTime.UtcNow;

        _db.ActivityParticipants.Add(new ActivityParticipant
        {
            Id = Guid.CreateVersion7(),
            ActivityId = request.ActivityId,
            UserId = request.UserId,
            JoinedAt = DateTime.UtcNow
        });

        request.Activity.CurrentPeopleCount++;
        if (request.Activity.CurrentPeopleCount - 1 >= request.Activity.NeededPeopleCount)
            request.Activity.Status = ActivityStatus.Full;

        await _db.SaveChangesAsync();

        await _notifications.SendAsync(request.UserId, NotificationType.RequestApproved,
            "Katılım isteğiniz onaylandı", null, request.ActivityId);
    }

    public async Task RejectAsync(Guid requestId, Guid userId)
    {
        var request = await _db.ActivityRequests.Include(r => r.Activity)
            .FirstOrDefaultAsync(r => r.Id == requestId)
            ?? throw new KeyNotFoundException("İstek bulunamadı.");

        if (request.Activity.CreatedByUserId != userId)
            throw new UnauthorizedAccessException("Bu isteği reddedemezsinisiniz.");

        if (request.Status != ActivityRequestStatus.Pending)
            throw new InvalidOperationException("İstek zaten yanıtlandı.");

        request.Status = ActivityRequestStatus.Rejected;
        request.RespondedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();

        await _notifications.SendAsync(request.UserId, NotificationType.RequestRejected,
            "Katılım isteğiniz reddedildi", request.Message, request.ActivityId);
    }

    public async Task CancelAsync(Guid requestId, Guid userId)
    {
        var request = await _db.ActivityRequests.FirstOrDefaultAsync(r => r.Id == requestId)
            ?? throw new KeyNotFoundException("İstek bulunamadı.");

        if (request.UserId != userId)
            throw new UnauthorizedAccessException("Bu isteği iptal edemezsiniz.");

        if (request.Status != ActivityRequestStatus.Pending)
            throw new InvalidOperationException("Sadece bekleyen istekler iptal edilebilir.");

        request.Status = ActivityRequestStatus.Cancelled;
        request.RespondedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
    }

    private static ActivityJoinRequestResponse MapToResponse(ActivityRequest r, Entities.User? user) => new()
    {
        Id = r.Id,
        ActivityId = r.ActivityId,
        Message = r.Message,
        Status = r.Status,
        CreatedAt = r.CreatedAt,
        RespondedAt = r.RespondedAt,
        User = new PublicProfileResponse
        {
            UserId = r.UserId,
            DisplayName = user?.Profile?.DisplayName ?? string.Empty,
            AvatarUrl = user?.Profile?.AvatarUrl,
            AverageRating = user?.Profile?.AverageRating ?? 0,
            ReviewCount = user?.Profile?.ReviewCount ?? 0,
            CompletedActivityCount = user?.Profile?.CompletedActivityCount ?? 0
        }
    };
}
