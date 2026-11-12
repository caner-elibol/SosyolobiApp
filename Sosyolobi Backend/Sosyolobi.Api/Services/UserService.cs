using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class UserService : IUserService
{
    private readonly AppDbContext _db;

    public UserService(AppDbContext db) => _db = db;

    public async Task<PublicProfileResponse?> GetPublicProfileAsync(Guid userId)
    {
        var profile = await _db.UserProfiles
            .Where(p => p.UserId == userId)
            .Select(p => new PublicProfileResponse
            {
                UserId = p.UserId,
                DisplayName = p.DisplayName,
                Bio = p.Bio,
                AvatarUrl = p.AvatarUrl,
                AverageRating = p.AverageRating,
                ReviewCount = p.ReviewCount,
                CompletedActivityCount = p.CompletedActivityCount
            })
            .FirstOrDefaultAsync();

        return profile;
    }

    public async Task BlockUserAsync(Guid blockerId, Guid blockedId)
    {
        if (blockerId == blockedId)
            throw new InvalidOperationException("Kendinizi engelleyemezsiniz.");

        var exists = await _db.UserBlocks.AnyAsync(b => b.BlockerUserId == blockerId && b.BlockedUserId == blockedId);
        if (exists) return;

        _db.UserBlocks.Add(new UserBlock
        {
            Id = Guid.CreateVersion7(),
            BlockerUserId = blockerId,
            BlockedUserId = blockedId,
            CreatedAt = DateTime.UtcNow
        });
        await _db.SaveChangesAsync();
    }

    public async Task UnblockUserAsync(Guid blockerId, Guid blockedId)
    {
        var block = await _db.UserBlocks.FirstOrDefaultAsync(b => b.BlockerUserId == blockerId && b.BlockedUserId == blockedId);
        if (block is null) return;

        _db.UserBlocks.Remove(block);
        await _db.SaveChangesAsync();
    }
}
