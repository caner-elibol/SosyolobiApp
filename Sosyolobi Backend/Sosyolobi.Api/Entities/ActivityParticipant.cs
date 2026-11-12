namespace Sosyolobi.Api.Entities;

public class ActivityParticipant
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public Guid UserId { get; set; }
    public DateTime JoinedAt { get; set; }
    public bool IsOrganizer { get; set; }
    public bool HasAttended { get; set; }

    public Activity Activity { get; set; } = null!;
    public User User { get; set; } = null!;
}
