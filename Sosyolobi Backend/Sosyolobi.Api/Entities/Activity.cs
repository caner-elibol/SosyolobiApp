using NetTopologySuite.Geometries;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Entities;

public class Activity
{
    public Guid Id { get; set; }
    public Guid CreatedByUserId { get; set; }
    public Guid CategoryId { get; set; }

    public string Title { get; set; } = null!;
    public string? Description { get; set; }

    public DateTime EventDate { get; set; }
    public int NeededPeopleCount { get; set; }
    public int CurrentPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }

    public SkillLevel SkillLevel { get; set; } = SkillLevel.Any;
    public GenderPreference GenderPreference { get; set; } = GenderPreference.Any;
    public ActivityStatus Status { get; set; } = ActivityStatus.Open;

    public Point Location { get; set; } = null!;
    public string AddressText { get; set; } = null!;
    public string? AddressDetailPrivate { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    public User CreatedByUser { get; set; } = null!;
    public ActivityCategory Category { get; set; } = null!;
    public ICollection<ActivityRequest> Requests { get; set; } = new List<ActivityRequest>();
    public ICollection<ActivityParticipant> Participants { get; set; } = new List<ActivityParticipant>();
    public ChatRoom? ChatRoom { get; set; }
}
