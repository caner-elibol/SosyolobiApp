using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Activities;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Hubs;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ActivityService : IActivityService
{
    private readonly AppDbContext _db;
    private readonly IHubContext<ChatHub> _chatHub;

    public ActivityService(AppDbContext db, IHubContext<ChatHub> chatHub)
    {
        _db = db;
        _chatHub = chatHub;
    }

    public async Task<ActivityResponse> CreateAsync(Guid userId, CreateActivityRequest request)
    {
        var category = await _db.ActivityCategories.FindAsync(request.CategoryId)
            ?? throw new KeyNotFoundException("Kategori bulunamadı.");

        var activity = new Activity
        {
            Id = Guid.CreateVersion7(),
            CreatedByUserId = userId,
            CategoryId = request.CategoryId,
            Title = request.Title,
            Description = request.Description,
            EventDate = request.EventDate.ToUniversalTime(),
            NeededPeopleCount = request.NeededPeopleCount,
            CurrentPeopleCount = 1,
            PricePerPerson = request.PricePerPerson,
            SkillLevel = request.SkillLevel,
            GenderPreference = request.GenderPreference,
            Status = ActivityStatus.Open,
            Location = new Point(request.Longitude, request.Latitude) { SRID = 4326 },
            AddressText = request.AddressText,
            AddressDetailPrivate = request.AddressDetailPrivate,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow
        };

        _db.Activities.Add(activity);

        _db.ActivityParticipants.Add(new ActivityParticipant
        {
            Id = Guid.CreateVersion7(),
            ActivityId = activity.Id,
            UserId = userId,
            JoinedAt = DateTime.UtcNow,
            IsOrganizer = true,
            HasAttended = false
        });

        _db.ChatRooms.Add(new ChatRoom
        {
            Id = Guid.CreateVersion7(),
            ActivityId = activity.Id,
            Status = ChatRoomStatus.Open,
            CreatedAt = DateTime.UtcNow
        });

        await _db.SaveChangesAsync();
        activity.Category = category;
        return MapToResponse(activity);
    }

    private static readonly TimeSpan AutoCompleteWindow = TimeSpan.FromHours(3);

    public async Task<PagedResponse<ActivityResponse>> GetListAsync(PagedRequest paged)
    {
        var query = _db.Activities
            .Include(a => a.Category)
            .Include(a => a.CreatedByUser).ThenInclude(u => u.Profile)
            .Where(a => (a.Status == ActivityStatus.Open || a.Status == ActivityStatus.Full)
                && a.EventDate >= DateTime.UtcNow - AutoCompleteWindow)
            .OrderByDescending(a => a.CreatedAt);

        var total = await query.CountAsync();
        var items = await query.Skip((paged.Page - 1) * paged.PageSize).Take(paged.PageSize).ToListAsync();

        return new PagedResponse<ActivityResponse>
        {
            Items = items.Select(MapToResponse).ToList(),
            TotalCount = total,
            Page = paged.Page,
            PageSize = paged.PageSize
        };
    }

    public async Task<IList<ActivityResponse>> GetNearbyAsync(NearbyActivitiesRequest request)
    {
        var userLocation = new Point(request.Longitude, request.Latitude) { SRID = 4326 };

        var query = _db.Activities
            .Include(a => a.Category)
            .Include(a => a.CreatedByUser).ThenInclude(u => u.Profile)
            .Where(a => a.Status == ActivityStatus.Open || a.Status == ActivityStatus.Full)
            .Where(a => a.EventDate >= DateTime.UtcNow - AutoCompleteWindow)
            .Where(a => a.Location.Distance(userLocation) <= request.RadiusMeters);

        if (request.CategoryId.HasValue)
            query = query.Where(a => a.CategoryId == request.CategoryId.Value);

        if (request.FromDate.HasValue)
            query = query.Where(a => a.EventDate >= request.FromDate.Value.ToUniversalTime());

        if (request.ToDate.HasValue)
            query = query.Where(a => a.EventDate <= request.ToDate.Value.ToUniversalTime());

        if (request.GenderPreference.HasValue && request.GenderPreference.Value != GenderPreference.Any)
            query = query.Where(a => a.GenderPreference == GenderPreference.Any || a.GenderPreference == request.GenderPreference.Value);

        if (request.IsFree.HasValue)
            query = request.IsFree.Value
                ? query.Where(a => a.PricePerPerson == null || a.PricePerPerson == 0)
                : query.Where(a => a.PricePerPerson != null && a.PricePerPerson > 0);

        var items = await query.OrderBy(a => a.Location.Distance(userLocation)).ToListAsync();

        return items.Select(a =>
        {
            var r = MapToResponse(a);
            r.DistanceMeters = a.Location.Distance(userLocation)*111_320;
            return r;
        }).ToList();
    }

    private IQueryable<Activity> BuildMapQuery(NearbyActivitiesRequest request, Point userLocation)
    {
        var query = _db.Activities
            .Include(a => a.Category)
            .Where(a => a.Status == ActivityStatus.Open || a.Status == ActivityStatus.Full)
            .Where(a => a.EventDate >= DateTime.UtcNow - AutoCompleteWindow)
            .Where(a => a.Location.Distance(userLocation) <= request.RadiusMeters);

        if (request.CategoryId.HasValue)
            query = query.Where(a => a.CategoryId == request.CategoryId.Value);

        if (request.FromDate.HasValue)
            query = query.Where(a => a.EventDate >= request.FromDate.Value.ToUniversalTime());

        if (request.ToDate.HasValue)
            query = query.Where(a => a.EventDate <= request.ToDate.Value.ToUniversalTime());

        if (request.GenderPreference.HasValue && request.GenderPreference.Value != GenderPreference.Any)
            query = query.Where(a => a.GenderPreference == GenderPreference.Any || a.GenderPreference == request.GenderPreference.Value);

        if (request.IsFree.HasValue)
            query = request.IsFree.Value
                ? query.Where(a => a.PricePerPerson == null || a.PricePerPerson == 0)
                : query.Where(a => a.PricePerPerson != null && a.PricePerPerson > 0);

        return query;
    }

    private static ActivityMapItemResponse MapToMapItemResponse(Activity a, Point userLocation) => new()
    {
        Id = a.Id,
        Title = a.Title,
        CategoryName = a.Category?.Name ?? string.Empty,
        CategoryImageUrl = a.Category?.ImageUrl,
        Status = a.Status,
        Latitude = a.Location.Y,
        Longitude = a.Location.X,
        EventDate = a.EventDate,
        NeededPeopleCount = a.NeededPeopleCount,
        PricePerPerson = a.PricePerPerson,
        DistanceMeters = a.Location.Distance(userLocation) * 111_320
    };

    public async Task<IList<ActivityResponse>> GetMineUpcomingAsync(Guid userId)
    {
        var activities = await _db.Activities
            .Include(a => a.Category)
            .Include(a => a.CreatedByUser).ThenInclude(u => u.Profile)
            .Where(a => a.Participants.Any(p => p.UserId == userId))
            .Where(a => a.Status != ActivityStatus.Cancelled && a.Status != ActivityStatus.Completed)
            .Where(a => a.EventDate > DateTime.UtcNow)
            .OrderBy(a => a.EventDate)
            .ToListAsync();

        return activities.Select(MapToResponse).ToList();
    }

    public async Task<IList<ActivityMapItemResponse>> GetMapItemsAsync(NearbyActivitiesRequest request)
    {
        var userLocation = new Point(request.Longitude, request.Latitude) { SRID = 4326 };

        var activities = await BuildMapQuery(request, userLocation)
            .OrderBy(a => a.Location.Distance(userLocation))
            .ToListAsync();

        return activities.Select(a => MapToMapItemResponse(a, userLocation)).ToList();
    }

    public async Task<PagedResponse<ActivityMapItemResponse>> GetMapItemsPagedAsync(NearbyActivitiesRequest request, PagedRequest paged)
    {
        var userLocation = new Point(request.Longitude, request.Latitude) { SRID = 4326 };

        var query = BuildMapQuery(request, userLocation)
            .OrderBy(a => a.Location.Distance(userLocation));

        var total = await query.CountAsync();
        var activities = await query.Skip((paged.Page - 1) * paged.PageSize).Take(paged.PageSize).ToListAsync();

        return new PagedResponse<ActivityMapItemResponse>
        {
            Items = activities.Select(a => MapToMapItemResponse(a, userLocation)).ToList(),
            TotalCount = total,
            Page = paged.Page,
            PageSize = paged.PageSize
        };
    }

    public async Task<ActivityDetailResponse?> GetByIdAsync(Guid id, Guid? requestingUserId)
    {
        var activity = await _db.Activities
            .Include(a => a.Category)
            .Include(a => a.CreatedByUser).ThenInclude(u => u.Profile)
            .Include(a => a.Participants).ThenInclude(p => p.User).ThenInclude(u => u.Profile)
            .FirstOrDefaultAsync(a => a.Id == id);

        if (activity is null) return null;

        var response = new ActivityDetailResponse
        {
            Id = activity.Id,
            CreatedByUserId = activity.CreatedByUserId,
            CreatedByDisplayName = activity.CreatedByUser.Profile?.DisplayName ?? string.Empty,
            CreatedByAvatarUrl = activity.CreatedByUser.Profile?.AvatarUrl,
            CategoryId = activity.CategoryId,
            CategoryName = activity.Category.Name,
            CategoryImageUrl = activity.Category.ImageUrl,
            Title = activity.Title,
            Description = activity.Description,
            EventDate = activity.EventDate,
            NeededPeopleCount = activity.NeededPeopleCount,
            CurrentPeopleCount = activity.CurrentPeopleCount,
            PricePerPerson = activity.PricePerPerson,
            SkillLevel = activity.SkillLevel,
            GenderPreference = activity.GenderPreference,
            Status = activity.Status,
            Latitude = activity.Location.Y,
            Longitude = activity.Location.X,
            AddressText = activity.AddressText,
            CreatedAt = activity.CreatedAt,
            Participants = activity.Participants
                .Where(p => !p.IsOrganizer || p.UserId == activity.CreatedByUserId)
                .Select(p => new PublicProfileResponse
                {
                    UserId = p.UserId,
                    DisplayName = p.User.Profile?.DisplayName ?? string.Empty,
                    AvatarUrl = p.User.Profile?.AvatarUrl,
                    AverageRating = p.User.Profile?.AverageRating ?? 0,
                    ReviewCount = p.User.Profile?.ReviewCount ?? 0,
                    CompletedActivityCount = p.User.Profile?.CompletedActivityCount ?? 0
                }).ToList()
        };

        var isParticipant = requestingUserId.HasValue &&
            activity.Participants.Any(p => p.UserId == requestingUserId.Value);
        if (isParticipant)
            response.AddressDetailPrivate = activity.AddressDetailPrivate;

        if (requestingUserId.HasValue)
        {
            response.MyRequestStatus = await _db.ActivityRequests
                .Where(r => r.ActivityId == id && r.UserId == requestingUserId.Value)
                .OrderByDescending(r => r.CreatedAt)
                .Select(r => (ActivityRequestStatus?)r.Status)
                .FirstOrDefaultAsync();
        }

        return response;
    }

    public async Task<ActivityResponse> UpdateAsync(Guid id, Guid userId, UpdateActivityRequest request)
    {
        var activity = await _db.Activities.Include(a => a.Category)
            .FirstOrDefaultAsync(a => a.Id == id)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (activity.CreatedByUserId != userId)
            throw new UnauthorizedAccessException("Bu etkinliği düzenleyemezsiniz.");

        if (request.Title is not null) activity.Title = request.Title;
        if (request.Description is not null) activity.Description = request.Description;
        if (request.EventDate.HasValue) activity.EventDate = request.EventDate.Value.ToUniversalTime();
        if (request.NeededPeopleCount.HasValue) activity.NeededPeopleCount = request.NeededPeopleCount.Value;
        if (request.PricePerPerson.HasValue) activity.PricePerPerson = request.PricePerPerson.Value;
        if (request.SkillLevel.HasValue) activity.SkillLevel = request.SkillLevel.Value;
        if (request.GenderPreference.HasValue) activity.GenderPreference = request.GenderPreference.Value;
        if (request.AddressText is not null) activity.AddressText = request.AddressText;
        if (request.AddressDetailPrivate is not null) activity.AddressDetailPrivate = request.AddressDetailPrivate;
        activity.UpdatedAt = DateTime.UtcNow;

        await _db.SaveChangesAsync();
        return MapToResponse(activity);
    }

    public async Task DeleteAsync(Guid id, Guid userId)
    {
        var activity = await _db.Activities.FindAsync(id)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (activity.CreatedByUserId != userId)
            throw new UnauthorizedAccessException("Bu etkinliği silemezsiniz.");

        _db.Activities.Remove(activity);
        await _db.SaveChangesAsync();
    }

    public async Task CancelAsync(Guid id, Guid userId)
    {
        var activity = await _db.Activities.FindAsync(id)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (activity.CreatedByUserId != userId)
            throw new UnauthorizedAccessException("Bu etkinliği iptal edemezsiniz.");

        activity.Status = ActivityStatus.Cancelled;
        activity.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
        await CloseChatRoomAsync(id);
    }

    public async Task CompleteAsync(Guid id, Guid userId)
    {
        var activity = await _db.Activities.FindAsync(id)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (activity.CreatedByUserId != userId)
            throw new UnauthorizedAccessException("Bu etkinliği tamamlayamazsınız.");

        activity.Status = ActivityStatus.Completed;
        activity.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
        await CloseChatRoomAsync(id);
    }

    public async Task CloseChatRoomAsync(Guid activityId)
    {
        var room = await _db.ChatRooms.FirstOrDefaultAsync(r => r.ActivityId == activityId);
        if (room is null || room.Status == ChatRoomStatus.Closed) return;

        room.Status = ChatRoomStatus.Closed;
        room.ClosedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();

        await _chatHub.Clients.Group($"chatroom_{room.Id}").SendAsync("RoomClosed", new { room.Id, room.ClosedAt });
    }

    public async Task<IList<Guid>> AutoCompleteExpiredAsync()
    {
        var cutoff = DateTime.UtcNow - AutoCompleteWindow;

        var expired = await _db.Activities
            .Where(a => (a.Status == ActivityStatus.Open || a.Status == ActivityStatus.Full) && a.EventDate <= cutoff)
            .ToListAsync();

        if (expired.Count == 0) return Array.Empty<Guid>();

        foreach (var activity in expired)
        {
            activity.Status = ActivityStatus.Completed;
            activity.UpdatedAt = DateTime.UtcNow;
        }
        await _db.SaveChangesAsync();

        return expired.Select(a => a.Id).ToList();
    }

    private static ActivityResponse MapToResponse(Activity a) => new()
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
};
}
