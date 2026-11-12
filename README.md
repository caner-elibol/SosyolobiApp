# Sosyolobi

Sosyolobi is a location-based social activity platform where people can discover and join activities around them on a map, create their own activities, and meet new people.

## Features

- **Phone sign-in** — SMS/OTP verification, JWT + refresh token
- **Activities on a map** — nearby activity listing and clustering by location (PostGIS)
- **Activity management** — create and edit activities with category, skill level and gender preference; join requests
- **Real-time chat** — per-activity chat rooms (SignalR)
- **Notifications** — real-time notifications (SignalR)
- **Friends** — friend requests, user blocking
- **Profiles & reviews** — profile photos, user reviews and ratings
- **Reporting** — report users and content
- **Admin panel** — manage users, activities, categories, reports and reviews; dashboard statistics

## Project Structure

```
Sosyolobi/
├── Sosyolobi Backend/    # ASP.NET Core 10 Web API
├── sosyolobi-web-2/      # Next.js web app (user app + admin panel)
└── sosyolobi-mobile/     # Flutter mobile app (Android / iOS)
```

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | ASP.NET Core 10, Entity Framework Core, SignalR, Swagger |
| Database | PostgreSQL 16 + PostGIS |
| Cache | Redis |
| Web | Next.js 16, React 19, TypeScript, Tailwind CSS 4, TanStack Query, MapLibre |
| Mobile | Flutter, Riverpod, Dio, go_router, MapLibre |
| Infrastructure | Docker / Docker Compose |

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) and Docker Compose
- [.NET 10 SDK](https://dotnet.microsoft.com/) (to run without Docker)
- [Node.js](https://nodejs.org/) 20+
- [Flutter SDK](https://flutter.dev/) 3.x

### 1. Backend

Set up environment variables (optional — anything left empty falls back to the defaults):

```bash
cd "Sosyolobi Backend"
cp .env.example .env   # JWT_SECRET, PEXELS_API_KEY, POSTGRES_PASSWORD
```

Start the database and the API together with Docker Compose:

```bash
docker compose up -d --build
```

- API: http://localhost:5000
- Swagger: http://localhost:5000/swagger
- PostgreSQL: `localhost:5433`

Migrations and seed data are applied automatically on startup.

### 2. Web

```bash
cd sosyolobi-web-2
cp .env.example .env.local   # NEXT_PUBLIC_API_URL=http://localhost:5000
npm install
npm run dev
```

The web app runs at http://localhost:3000. The admin panel is under `/admin`.

### 3. Mobile

The API URL is read from `sosyolobi-mobile/env/dev.json` and `env/prod.json`. The default for the Android emulator is `http://10.0.2.2:5000`.

```bash
cd sosyolobi-mobile
flutter pub get
flutter run -t lib/main_dev.dart --dart-define-from-file=env/dev.json
```

## Configuration

`appsettings.json` only contains default/placeholder values. Real secrets (JWT key, Pexels API key, database password) are provided via environment variables: `Sosyolobi Backend/.env` when running with Docker, or environment variables such as `Jwt__Secret` and `Pexels__ApiKey` (or `dotnet user-secrets`) when running directly. `.env` and `appsettings.{Environment}.json` files are excluded from the repository via `.gitignore`.

> **Note:** While `Sms:DevelopmentMode` is enabled, the OTP code is fixed (`123456`) and no SMS is sent. It must be disabled in production.

## License

This is a private project; all rights reserved.
