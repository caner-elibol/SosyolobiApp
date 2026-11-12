using System.Net;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Chat;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Exceptions;
using Sosyolobi.Api.Hubs;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ChatService : IChatService
{
    private readonly AppDbContext _db;
    private readonly IHubContext<ChatHub> _hub;

    public ChatService(AppDbContext db, IHubContext<ChatHub> hub)
    {
        _db = db;
        _hub = hub;
    }

    public async Task<ChatRoomResponse> GetRoomForActivityAsync(Guid activityId, Guid userId)
    {
        var activity = await _db.Activities.Include(a => a.Participants)
            .FirstOrDefaultAsync(a => a.Id == activityId)
            ?? throw new KeyNotFoundException("Etkinlik bulunamadı.");

        if (!activity.Participants.Any(p => p.UserId == userId))
            throw new UnauthorizedAccessException("Bu sohbet odasına erişiminiz yok.");

        var room = await _db.ChatRooms.FirstOrDefaultAsync(r => r.ActivityId == activityId);
        if (room is null)
        {
            room = new ChatRoom
            {
                Id = Guid.CreateVersion7(),
                ActivityId = activityId,
                Status = activity.Status is ActivityStatus.Completed or ActivityStatus.Cancelled
                    ? ChatRoomStatus.Closed
                    : ChatRoomStatus.Open,
                CreatedAt = DateTime.UtcNow,
                ClosedAt = activity.Status is ActivityStatus.Completed or ActivityStatus.Cancelled
                    ? DateTime.UtcNow
                    : null
            };
            _db.ChatRooms.Add(room);
            await _db.SaveChangesAsync();
        }

        return MapToResponse(room);
    }

    public async Task<PagedResponse<ChatMessageResponse>> GetMessagesAsync(Guid roomId, Guid userId, PagedRequest paged)
    {
        var room = await _db.ChatRooms.Include(r => r.Activity).ThenInclude(a => a.Participants)
            .FirstOrDefaultAsync(r => r.Id == roomId)
            ?? throw new KeyNotFoundException("Sohbet odası bulunamadı.");

        if (!room.Activity.Participants.Any(p => p.UserId == userId))
            throw new UnauthorizedAccessException("Bu sohbet odasına erişiminiz yok.");

        var query = _db.ChatMessages
            .Include(m => m.SenderUser).ThenInclude(u => u.Profile)
            .Include(m => m.ReplyToMessage).ThenInclude(r => r!.SenderUser).ThenInclude(u => u.Profile)
            .Where(m => m.ChatRoomId == roomId)
            .OrderByDescending(m => m.CreatedAt);

        var total = await query.CountAsync();
        var items = await query.Skip((paged.Page - 1) * paged.PageSize).Take(paged.PageSize).ToListAsync();

        return new PagedResponse<ChatMessageResponse>
        {
            Items = items.Select(m => MapToResponse(m)).ToList(),
            TotalCount = total,
            Page = paged.Page,
            PageSize = paged.PageSize
        };
    }

    private const int RateLimitMaxMessages = 5;
    private static readonly TimeSpan RateLimitWindow = TimeSpan.FromSeconds(60);

    public async Task<ChatMessageResponse> SendMessageAsync(Guid roomId, Guid userId, SendChatMessageRequest request)
    {
        var room = await _db.ChatRooms.Include(r => r.Activity).ThenInclude(a => a.Participants)
            .FirstOrDefaultAsync(r => r.Id == roomId)
            ?? throw new KeyNotFoundException("Sohbet odası bulunamadı.");

        if (!room.Activity.Participants.Any(p => p.UserId == userId))
            throw new UnauthorizedAccessException("Bu sohbet odasına erişiminiz yok.");

        if (room.Status != ChatRoomStatus.Open)
            throw new InvalidOperationException("Bu sohbet odası kapatıldı.");

        var sender = await _db.Users.Include(u => u.Profile).FirstAsync(u => u.Id == userId);

        if (string.IsNullOrWhiteSpace(sender.Profile?.DisplayName))
            throw new ApiException("PROFILE_INCOMPLETE", "Mesaj göndermeden önce profilinizde bir görünen ad belirlemelisiniz.");

        var since = DateTime.UtcNow - RateLimitWindow;
        var recentCount = await _db.ChatMessages.CountAsync(m =>
            m.ChatRoomId == roomId && m.SenderUserId == userId && m.CreatedAt >= since);
        if (recentCount >= RateLimitMaxMessages)
            throw new ApiException("RATE_LIMITED", "Çok hızlı mesaj gönderiyorsunuz. Lütfen biraz bekleyin.", HttpStatusCode.TooManyRequests);

        ChatMessage? replyToMessage = null;
        if (request.ReplyToMessageId.HasValue)
        {
            replyToMessage = await _db.ChatMessages.Include(m => m.SenderUser).ThenInclude(u => u.Profile)
                .FirstOrDefaultAsync(m => m.Id == request.ReplyToMessageId.Value && m.ChatRoomId == roomId)
                ?? throw new KeyNotFoundException("Yanıtlanan mesaj bulunamadı.");
        }

        var message = new ChatMessage
        {
            Id = Guid.CreateVersion7(),
            ChatRoomId = roomId,
            SenderUserId = userId,
            Content = request.Content,
            ReplyToMessageId = replyToMessage?.Id,
            CreatedAt = DateTime.UtcNow
        };
        _db.ChatMessages.Add(message);
        await _db.SaveChangesAsync();

        var response = MapToResponse(message, sender, replyToMessage);

        await _hub.Clients.Group($"chatroom_{roomId}").SendAsync("ReceiveMessage", response);

        return response;
    }

    public async Task<IList<ChatUnreadSummaryResponse>> GetUnreadSummaryAsync(Guid userId)
    {
        var rooms = await _db.ChatRooms
            .Where(r => r.Status == ChatRoomStatus.Open && r.Activity.Participants.Any(p => p.UserId == userId))
            .Select(r => new { r.Id, r.ActivityId, ActivityTitle = r.Activity.Title })
            .ToListAsync();

        if (rooms.Count == 0) return [];

        var roomIds = rooms.Select(r => r.Id).ToList();
        var lastReads = await _db.ChatRoomReads
            .Where(x => x.UserId == userId && roomIds.Contains(x.ChatRoomId))
            .ToDictionaryAsync(x => x.ChatRoomId, x => x.LastReadAt);

        var result = new List<ChatUnreadSummaryResponse>();
        foreach (var room in rooms)
        {
            var since = lastReads.TryGetValue(room.Id, out var lastReadAt) ? lastReadAt : DateTime.MinValue;
            var unreadCount = await _db.ChatMessages.CountAsync(m =>
                m.ChatRoomId == room.Id && m.SenderUserId != userId && m.CreatedAt > since);

            if (unreadCount > 0)
            {
                result.Add(new ChatUnreadSummaryResponse
                {
                    ActivityId = room.ActivityId,
                    ActivityTitle = room.ActivityTitle,
                    ChatRoomId = room.Id,
                    UnreadCount = unreadCount
                });
            }
        }

        return result;
    }

    public async Task MarkRoomReadAsync(Guid roomId, Guid userId)
    {
        var isParticipant = await _db.ChatRooms
            .Where(r => r.Id == roomId)
            .SelectMany(r => r.Activity.Participants)
            .AnyAsync(p => p.UserId == userId);
        if (!isParticipant) throw new UnauthorizedAccessException("Bu sohbet odasına erişiminiz yok.");

        var read = await _db.ChatRoomReads.FirstOrDefaultAsync(x => x.UserId == userId && x.ChatRoomId == roomId);
        if (read is null)
        {
            _db.ChatRoomReads.Add(new ChatRoomRead
            {
                Id = Guid.CreateVersion7(),
                UserId = userId,
                ChatRoomId = roomId,
                LastReadAt = DateTime.UtcNow
            });
        }
        else
        {
            read.LastReadAt = DateTime.UtcNow;
        }

        await _db.SaveChangesAsync();
    }

    private static ChatRoomResponse MapToResponse(ChatRoom r) => new()
    {
        Id = r.Id,
        ActivityId = r.ActivityId,
        Status = r.Status,
        CreatedAt = r.CreatedAt,
        ClosedAt = r.ClosedAt
    };

    private static ChatMessageResponse MapToResponse(ChatMessage m, User? sender = null, ChatMessage? replyToMessage = null)
    {
        var user = sender ?? m.SenderUser;
        var replyTo = replyToMessage ?? m.ReplyToMessage;
        return new ChatMessageResponse
        {
            Id = m.Id,
            ChatRoomId = m.ChatRoomId,
            SenderUserId = m.SenderUserId,
            SenderDisplayName = user?.Profile?.DisplayName ?? string.Empty,
            SenderAvatarUrl = user?.Profile?.AvatarUrl,
            Content = m.Content,
            ReplyTo = replyTo is null ? null : new ChatMessageReplyPreview
            {
                Id = replyTo.Id,
                SenderDisplayName = replyTo.SenderUser?.Profile?.DisplayName ?? string.Empty,
                Content = replyTo.Content.Length > 120 ? replyTo.Content[..120] : replyTo.Content
            },
            CreatedAt = m.CreatedAt
        };
    }
}
