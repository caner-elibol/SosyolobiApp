using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.Enums;
using Sosyolobi.Api.Extensions;

namespace Sosyolobi.Api.Hubs;

[Authorize]
public class ChatHub : Hub
{
    private readonly AppDbContext _db;

    public ChatHub(AppDbContext db) => _db = db;

    public override async Task OnConnectedAsync()
    {
        var userId = Context.User!.GetUserId();

        var roomIds = await _db.ChatRooms
            .Where(r => r.Status == ChatRoomStatus.Open && r.Activity.Participants.Any(p => p.UserId == userId))
            .Select(r => r.Id)
            .ToListAsync();

        foreach (var roomId in roomIds)
            await Groups.AddToGroupAsync(Context.ConnectionId, $"chatroom_{roomId}");

        await base.OnConnectedAsync();
    }

    public async Task JoinRoom(Guid roomId)
    {
        var userId = Context.User!.GetUserId();

        var isParticipant = await _db.ChatRooms
            .Where(r => r.Id == roomId)
            .SelectMany(r => r.Activity.Participants)
            .AnyAsync(p => p.UserId == userId);

        if (!isParticipant) throw new HubException("Bu sohbet odasına erişiminiz yok.");

        await Groups.AddToGroupAsync(Context.ConnectionId, $"chatroom_{roomId}");
    }

    public async Task LeaveRoom(Guid roomId)
    {
        await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"chatroom_{roomId}");
    }
}
