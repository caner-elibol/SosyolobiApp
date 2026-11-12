using Microsoft.EntityFrameworkCore;

namespace Sosyolobi.Api.Data;

public static class DbInitializer
{
    public static async Task InitializeAsync(IServiceProvider serviceProvider)
    {
        using var scope = serviceProvider.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
        var env = scope.ServiceProvider.GetRequiredService<IHostEnvironment>();

        await db.Database.MigrateAsync();
        await SeedData.SeedAsync(db);
        await SeedData.SeedDummyActivitiesAsync(db);

        //if (env.IsDevelopment())
        //    await SeedData.SeedDummyActivitiesAsync(db);
    }
}
