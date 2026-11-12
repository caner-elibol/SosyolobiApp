using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Friends;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class FriendService : IFriendService
{
    private readonly AppDbContext _db;
    private readonly INotificationService _notifications;

    public FriendService(AppDbContext db, INotificationService notifications)
    {
        _db = db;
        _notifications = notifications;
    }

    public async Task<FriendRequestResponse> SendRequestAsync(Guid requesterUserId, Guid addresseeUserId)
    {
        if (requesterUserId == addresseeUserId)
            throw new InvalidOperationException("Kendinize arkadaşlık isteği gönderemezsiniz.");

        var addressee = await _db.Users.Include(u => u.Profile).FirstOrDefaultAsync(u => u.Id == addresseeUserId)
            ?? throw new KeyNotFoundException("Kullanıcı bulunamadı.");

        var isBlocked = await _db.UserBlocks.AnyAsync(b =>
            (b.BlockerUserId == requesterUserId && b.BlockedUserId == addresseeUserId) ||
            (b.BlockerUserId == addresseeUserId && b.BlockedUserId == requesterUserId));
        if (isBlocked)
            throw new InvalidOperationException("Bu kullanıcıya istek gönderilemiyor.");

        var existing = await _db.FriendRequests.FirstOrDefaultAsync(r =>
            (r.RequesterUserId == requesterUserId && r.AddresseeUserId == addresseeUserId) ||
            (r.RequesterUserId == addresseeUserId && r.AddresseeUserId == requesterUserId));

        if (existing is not null)
        {
            if (existing.Status is FriendRequestStatus.Accepted)
                throw new InvalidOperationException("Zaten arkadaşsınız.");
            if (existing.Status is FriendRequestStatus.Pending)
                throw new InvalidOperationException("Zaten bekleyen bir arkadaşlık isteği var.");

            if (existing.RequesterUserId == requesterUserId)
            {
                existing.Status = FriendRequestStatus.Pending;
                existing.CreatedAt = DateTime.UtcNow;
                existing.RespondedAt = null;
                await _db.SaveChangesAsync();
                await _notifications.SendAsync(addresseeUserId, NotificationType.FriendRequestReceived,
                    "Yeni arkadaşlık isteği", null);
                return MapToResponse(existing, addressee);
            }

            _db.FriendRequests.Remove(existing);
        }

        var request = new FriendRequest
        {
            Id = Guid.CreateVersion7(),
            RequesterUserId = requesterUserId,
            AddresseeUserId = addresseeUserId,
            Status = FriendRequestStatus.Pending,
            CreatedAt = DateTime.UtcNow
        };
        _db.FriendRequests.Add(request);
        await _db.SaveChangesAsync();

        await _notifications.SendAsync(addresseeUserId, NotificationType.FriendRequestReceived,
            "Yeni arkadaşlık isteği", null);

        return MapToResponse(request, addressee);
    }

    public async Task<IList<FriendRequestResponse>> GetIncomingRequestsAsync(Guid userId)
    {
        var requests = await _db.FriendRequests
            .Include(r => r.RequesterUser).ThenInclude(u => u.Profile)
            .Where(r => r.AddresseeUserId == userId && r.Status == FriendRequestStatus.Pending)
            .OrderByDescending(r => r.CreatedAt)
            .ToListAsync();

        return requests.Select(r => MapToResponse(r, r.RequesterUser)).ToList();
    }

    public async Task<IList<FriendRequestResponse>> GetSentRequestsAsync(Guid userId)
    {
        var requests = await _db.FriendRequests
            .Include(r => r.AddresseeUser).ThenInclude(u => u.Profile)
            .Where(r => r.RequesterUserId == userId && r.Status == FriendRequestStatus.Pending)
            .OrderByDescending(r => r.CreatedAt)
            .ToListAsync();

        return requests.Select(r => MapToResponse(r, r.AddresseeUser)).ToList();
    }

    public async Task AcceptAsync(Guid requestId, Guid userId)
    {
        var request = await _db.FriendRequests.FirstOrDefaultAsync(r => r.Id == requestId)
            ?? throw new KeyNotFoundException("İstek bulunamadı.");

        if (request.AddresseeUserId != userId)
            throw new UnauthorizedAccessException("Bu isteği kabul edemezsiniz.");

        if (request.Status != FriendRequestStatus.Pending)
            throw new InvalidOperationException("İstek zaten yanıtlandı.");

        request.Status = FriendRequestStatus.Accepted;
        request.RespondedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();

        await _notifications.SendAsync(request.RequesterUserId, NotificationType.FriendRequestAccepted,
            "Arkadaşlık isteğiniz kabul edildi", null);
    }

    public async Task RejectAsync(Guid requestId, Guid userId)
    {
        var request = await _db.FriendRequests.FirstOrDefaultAsync(r => r.Id == requestId)
            ?? throw new KeyNotFoundException("İstek bulunamadı.");

        if (request.AddresseeUserId != userId)
            throw new UnauthorizedAccessException("Bu isteği reddedemezsiniz.");

        if (request.Status != FriendRequestStatus.Pending)
            throw new InvalidOperationException("İstek zaten yanıtlandı.");

        request.Status = FriendRequestStatus.Rejected;
        request.RespondedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
    }

    public async Task CancelAsync(Guid requestId, Guid userId)
    {
        var request = await _db.FriendRequests.FirstOrDefaultAsync(r => r.Id == requestId)
            ?? throw new KeyNotFoundException("İstek bulunamadı.");

        if (request.RequesterUserId != userId)
            throw new UnauthorizedAccessException("Bu isteği iptal edemezsiniz.");

        if (request.Status != FriendRequestStatus.Pending)
            throw new InvalidOperationException("Sadece bekleyen istekler iptal edilebilir.");

        request.Status = FriendRequestStatus.Cancelled;
        request.RespondedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
    }

    public async Task<IList<FriendResponse>> GetFriendsAsync(Guid userId)
    {
        var accepted = await _db.FriendRequests
            .Include(r => r.RequesterUser).ThenInclude(u => u.Profile)
            .Include(r => r.AddresseeUser).ThenInclude(u => u.Profile)
            .Where(r => r.Status == FriendRequestStatus.Accepted
                && (r.RequesterUserId == userId || r.AddresseeUserId == userId))
            .OrderByDescending(r => r.RespondedAt)
            .ToListAsync();

        return accepted.Select(r =>
        {
            var other = r.RequesterUserId == userId ? r.AddresseeUser : r.RequesterUser;
            return new FriendResponse
            {
                FriendsSinceUtc = r.RespondedAt ?? r.CreatedAt,
                User = ToPublicProfile(other)
            };
        }).ToList();
    }

    public async Task RemoveFriendAsync(Guid friendUserId, Guid userId)
    {
        var request = await _db.FriendRequests.FirstOrDefaultAsync(r =>
            r.Status == FriendRequestStatus.Accepted &&
            ((r.RequesterUserId == userId && r.AddresseeUserId == friendUserId) ||
             (r.RequesterUserId == friendUserId && r.AddresseeUserId == userId)))
            ?? throw new KeyNotFoundException("Arkadaşlık bulunamadı.");

        _db.FriendRequests.Remove(request);
        await _db.SaveChangesAsync();
    }

    public async Task<IList<ActivityResponse>> GetFriendActivitiesAsync(Guid friendUserId, Guid requestingUserId)
    {
        if (friendUserId != requestingUserId)
        {
            var isFriend = await _db.FriendRequests.AnyAsync(r =>
                r.Status == FriendRequestStatus.Accepted &&
                ((r.RequesterUserId == requestingUserId && r.AddresseeUserId == friendUserId) ||
                 (r.RequesterUserId == friendUserId && r.AddresseeUserId == requestingUserId)));

            if (!isFriend)
                throw new UnauthorizedAccessException("Bu kullanıcının etkinliklerini görüntüleyemezsiniz.");
        }

        var activities = await _db.Activities
            .Include(a => a.Category)
            .Include(a => a.CreatedByUser).ThenInclude(u => u.Profile)
            .Where(a => a.CreatedByUserId == friendUserId && a.Status != ActivityStatus.Cancelled)
            .OrderByDescending(a => a.EventDate)
            .ToListAsync();

        return activities.Select(a => new ActivityResponse
        {
            Id = a.Id,
            CreatedByUserId = a.CreatedByUserId,
            CreatedByDisplayName = a.CreatedByUser?.Profile?.DisplayName ?? string.Empty,
            CreatedByAvatarUrl = a.CreatedByUser?.Profile?.AvatarUrl,
            CategoryId = a.CategoryId,
            CategoryName = a.Category?.Name ?? string.Empty,
            CategoryImageUrl = a.Category?.ImageUrl,
            Title = a.Title,
            Description = a.Description,
            EventDate = a.EventDate,
            NeededPeopleCount = a.NeededPeopleCount,
            CurrentPeopleCount = a.CurrentPeopleCount,
            PricePerPerson = a.PricePerPerson,
            SkillLevel = a.SkillLevel,
            GenderPreference = a.GenderPreference,
            Status = a.Status,
            Latitude = a.Location.Y,
            Longitude = a.Location.X,
            AddressText = a.AddressText,
            CreatedAt = a.CreatedAt
        }).ToList();
    }

    private static FriendRequestResponse MapToResponse(FriendRequest r, User otherUser) => new()
    {
        Id = r.Id,
        Status = r.Status,
        CreatedAt = r.CreatedAt,
        RespondedAt = r.RespondedAt,
        User = ToPublicProfile(otherUser)
    };

    private static PublicProfileResponse ToPublicProfile(User u) => new()
    {
        UserId = u.Id,
        DisplayName = u.Profile?.DisplayName ?? string.Empty,
        Bio = u.Profile?.Bio,
        AvatarUrl = u.Profile?.AvatarUrl,
        AverageRating = u.Profile?.AverageRating ?? 0,
        ReviewCount = u.Profile?.ReviewCount ?? 0,
        CompletedActivityCount = u.Profile?.CompletedActivityCount ?? 0
    };
}
