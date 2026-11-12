using Sosyolobi.Api.Services.Interfaces;

namespace Sosyolobi.Api.Services;

public class ActivityAutoCompletionService : BackgroundService
{
    private static readonly TimeSpan PollInterval = TimeSpan.FromMinutes(5);

    private readonly IServiceScopeFactory _scopeFactory;
    private readonly ILogger<ActivityAutoCompletionService> _logger;

    public ActivityAutoCompletionService(IServiceScopeFactory scopeFactory, ILogger<ActivityAutoCompletionService> logger)
    {
        _scopeFactory = scopeFactory;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await RunOnceAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Etkinlik otomatik tamamlama taraması başarısız oldu.");
            }

            await Task.Delay(PollInterval, stoppingToken);
        }
    }

    private async Task RunOnceAsync()
    {
        using var scope = _scopeFactory.CreateScope();
        var activityService = scope.ServiceProvider.GetRequiredService<IActivityService>();

        var completedIds = await activityService.AutoCompleteExpiredAsync();
        foreach (var activityId in completedIds)
            await activityService.CloseChatRoomAsync(activityId);
    }
}
