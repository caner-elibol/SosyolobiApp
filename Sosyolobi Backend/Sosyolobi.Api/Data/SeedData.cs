using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;
using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Data;

public static class SeedData
{
    public static async Task SeedAsync(AppDbContext db)
    {
        if (await db.ActivityCategories.AnyAsync())
            return;

        var categories = new List<ActivityCategory>
        {
            new() { Id = Guid.NewGuid(), Name = "Futbol",                  Slug = "futbol",               IconName = "soccer",    Color = "#2ECC71", SortOrder = 1 },
            new() { Id = Guid.NewGuid(), Name = "Basketbol",               Slug = "basketbol",            IconName = "basketball",Color = "#E67E22", SortOrder = 2 },
            new() { Id = Guid.NewGuid(), Name = "Voleybol",                Slug = "voleybol",             IconName = "volleyball",Color = "#3498DB", SortOrder = 3 },
            new() { Id = Guid.NewGuid(), Name = "Tenis",                   Slug = "tenis",                IconName = "tennis",    Color = "#F1C40F", SortOrder = 4 },
            new() { Id = Guid.NewGuid(), Name = "Koşu",                    Slug = "kosu",                 IconName = "run",       Color = "#E74C3C", SortOrder = 5 },
            new() { Id = Guid.NewGuid(), Name = "Bisiklet",                Slug = "bisiklet",             IconName = "bike",      Color = "#9B59B6", SortOrder = 6 },
            new() { Id = Guid.NewGuid(), Name = "Yürüyüş",                 Slug = "yuruyus",              IconName = "hiking",    Color = "#1ABC9C", SortOrder = 7 },
            new() { Id = Guid.NewGuid(), Name = "Kamp",                    Slug = "kamp",                 IconName = "camping",   Color = "#27AE60", SortOrder = 8 },
            new() { Id = Guid.NewGuid(), Name = "Kayak",                   Slug = "kayak",                IconName = "ski",       Color = "#5DADE2", SortOrder = 9 },
            new() { Id = Guid.NewGuid(), Name = "Masa Oyunu",              Slug = "masa-oyunu",           IconName = "game",      Color = "#E59866", SortOrder = 10 },
            new() { Id = Guid.NewGuid(), Name = "Konser",                  Slug = "konser",               IconName = "music",     Color = "#A569BD", SortOrder = 11 },
            new() { Id = Guid.NewGuid(), Name = "Kahve & Sosyal Buluşma",  Slug = "kahve-sosyal",         IconName = "coffee",    Color = "#D35400", SortOrder = 12 },
            new() { Id = Guid.NewGuid(), Name = "Diğer",                   Slug = "diger",                IconName = "other",     Color = "#95A5A6", SortOrder = 13 },
        };

        await db.ActivityCategories.AddRangeAsync(categories);
        await db.SaveChangesAsync();
    }

    private const string DummyPhonePrefix = "+90500";

    private static readonly (string District, double Lat, double Lng, double Spread)[] Districts =
    [
        ("Çekmeköy", 41.0361, 29.1786, 0.015),
        ("Ümraniye",  41.0165, 29.1240, 0.02),
        ("Beşiktaş",  41.0430, 29.0094, 0.012),
        ("Pendik",    40.8776, 29.2611, 0.02),
    ];

    private static readonly string[] FirstNames =
        ["Ahmet", "Mehmet", "Ayşe", "Fatma", "Mustafa", "Elif", "Emre", "Zeynep", "Can", "Deniz",
         "Burak", "Selin", "Kerem", "İrem", "Barış", "Gizem", "Onur", "Ece", "Yusuf", "Melis"];

    private static readonly string[] LastNames =
        ["Yılmaz", "Kaya", "Demir", "Şahin", "Çelik", "Yıldız", "Aydın", "Öztürk", "Arslan", "Doğan"];

    private static readonly string[] TitleTemplates =
        ["Akşam {0} Buluşması", "Hafta Sonu {0}", "{1} Bölgesinde {0}", "{0} Sevenler Buluşuyor", "Amatör {0} Maçı", "{0} ile Tanışma Etkinliği"];

    public static async Task SeedDummyActivitiesAsync(AppDbContext db)
    {
        if (await db.Users.AnyAsync(u => u.PhoneNumber.StartsWith(DummyPhonePrefix)))
            return;

        var categories = await db.ActivityCategories.ToListAsync();
        if (categories.Count == 0) return;

        var rng = Random.Shared;

        var dummyUsers = new List<User>();
        for (var i = 0; i < 20; i++)
        {
            var user = new User
            {
                Id = Guid.CreateVersion7(),
                PhoneNumber = $"{DummyPhonePrefix}{i:D7}",
                IsPhoneVerified = true,
                Role = "User",
                Status = UserStatus.Active,
                CreatedAt = DateTime.UtcNow
            };
            dummyUsers.Add(user);
            db.Users.Add(user);
            db.UserProfiles.Add(new UserProfile
            {
                Id = Guid.CreateVersion7(),
                UserId = user.Id,
                DisplayName = $"{FirstNames[rng.Next(FirstNames.Length)]} {LastNames[rng.Next(LastNames.Length)]}",
                AverageRating = 0,
                ReviewCount = 0,
                CompletedActivityCount = 0,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            });
        }

        var rangeStart = new DateTime(2026, 8, 15, 0, 0, 0, DateTimeKind.Utc);
        var rangeDays = (new DateTime(2026, 9, 15, 23, 59, 0, DateTimeKind.Utc) - rangeStart).TotalDays;

        for (var i = 0; i < 100; i++)
        {
            var category = categories[rng.Next(categories.Count)];
            var (district, lat, lng, spread) = Districts[rng.Next(Districts.Length)];
            var organizer = dummyUsers[rng.Next(dummyUsers.Count)];

            var eventDate = rangeStart
                .AddDays(rng.NextDouble() * rangeDays)
                .Date
                .AddHours(rng.Next(8, 22))
                .AddMinutes(rng.Next(0, 4) * 15);

            var title = string.Format(TitleTemplates[rng.Next(TitleTemplates.Length)], category.Name, district);
            var isFree = rng.NextDouble() < 0.6;

            var activity = new Activity
            {
                Id = Guid.CreateVersion7(),
                CreatedByUserId = organizer.Id,
                CategoryId = category.Id,
                Title = title,
                Description = $"{district} bölgesinde düzenlenen {category.Name.ToLowerInvariant()} etkinliği. Herkes davetli!",
                EventDate = eventDate,
                NeededPeopleCount = rng.Next(2, 11),
                CurrentPeopleCount = 1,
                PricePerPerson = isFree ? null : Math.Round((decimal)rng.Next(20, 150), 2),
                SkillLevel = (SkillLevel)rng.Next(0, 4),
                GenderPreference = (GenderPreference)rng.Next(0, 4),
                Status = ActivityStatus.Open,
                Location = new Point(
                    lng + (rng.NextDouble() * 2 - 1) * spread,
                    lat + (rng.NextDouble() * 2 - 1) * spread)
                { SRID = 4326 },
                AddressText = $"{district}, İstanbul",
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            db.Activities.Add(activity);

            db.ActivityParticipants.Add(new ActivityParticipant
            {
                Id = Guid.CreateVersion7(),
                ActivityId = activity.Id,
                UserId = organizer.Id,
                JoinedAt = DateTime.UtcNow,
                IsOrganizer = true,
                HasAttended = false
            });

            db.ChatRooms.Add(new ChatRoom
            {
                Id = Guid.CreateVersion7(),
                ActivityId = activity.Id,
                Status = ChatRoomStatus.Open,
                CreatedAt = DateTime.UtcNow
            });
        }

        await db.SaveChangesAsync();
    }
}
