using Sosyolobi.Api.DTOs.Common;
using Sosyolobi.Api.DTOs.Profiles;

namespace Sosyolobi.Api.Services.Interfaces;

public interface IUserService
{
    Task<PublicProfileResponse?> GetPublicProfileAsync(Guid userId);
    Task BlockUserAsync(Guid blockerId, Guid blockedId);
    Task UnblockUserAsync(Guid blockerId, Guid blockedId);
}
