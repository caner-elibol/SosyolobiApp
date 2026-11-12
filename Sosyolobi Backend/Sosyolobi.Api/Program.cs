using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;
using Sosyolobi.Api.Data;
using Sosyolobi.Api.Extensions;
using Sosyolobi.Api.Hubs;
using Sosyolobi.Api.Options;
using Sosyolobi.Api.Services;
using Sosyolobi.Api.Services.Interfaces;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(c =>
{
    c.CustomSchemaIds(type => type.FullName);
});
builder.Services.Configure<JwtOptions>(builder.Configuration.GetSection(JwtOptions.SectionName));
builder.Services.Configure<SmsOptions>(builder.Configuration.GetSection(SmsOptions.SectionName));
builder.Services.Configure<RedisOptions>(builder.Configuration.GetSection(RedisOptions.SectionName));
builder.Services.Configure<GeoOptions>(builder.Configuration.GetSection(GeoOptions.SectionName));
builder.Services.Configure<PexelsOptions>(builder.Configuration.GetSection(PexelsOptions.SectionName));

builder.Services.AddHttpClient<IPexelsImageService, PexelsImageService>(client =>
{
    client.BaseAddress = new Uri("https://api.pexels.com/v1/");
    client.Timeout = TimeSpan.FromSeconds(8);
});

builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseNpgsql(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        npgsqlOptions => npgsqlOptions.UseNetTopologySuite()
    )
    .UseSnakeCaseNamingConvention()
    .ReplaceService<IHistoryRepository, NamingConventionsHistoryRepository>();
});

builder.Services.AddJwtAuthentication(builder.Configuration);
builder.Services.AddAuthorization();

builder.Services.AddSignalR();

builder.Services.AddApplicationServices();
builder.Services.AddHostedService<ActivityAutoCompletionService>();

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.WithOrigins(builder.Configuration.GetSection("AllowedOrigins").Get<string[]>() ?? ["http://localhost:3000"])
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials();
    });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Sosyolobi API v1"));
}

app.UseExceptionHandling();
app.UseRequestLogging();

app.UseStaticFiles();
app.UseCors();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();
app.MapHub<NotificationHub>("/hubs/notifications");
app.MapHub<ChatHub>("/hubs/chat");

await DbInitializer.InitializeAsync(app.Services);

app.Run();
