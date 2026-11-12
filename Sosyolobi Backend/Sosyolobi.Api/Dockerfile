FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Sosyolobi.Api/Sosyolobi.Api.csproj", "Sosyolobi.Api/"]
RUN dotnet restore "Sosyolobi.Api/Sosyolobi.Api.csproj"
COPY . .
WORKDIR "/src/Sosyolobi.Api"
RUN dotnet build "Sosyolobi.Api.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "Sosyolobi.Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish --chown=$APP_UID:$APP_UID /app/publish .
RUN mkdir -p /app/wwwroot/avatars && chmod -R 777 /app/wwwroot/avatars
ENTRYPOINT ["dotnet", "Sosyolobi.Api.dll"]
