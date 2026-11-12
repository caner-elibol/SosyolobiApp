# Sosyolobi

Sosyolobi, insanların çevrelerindeki sosyal aktiviteleri harita üzerinde keşfedip katılabildiği, kendi aktivitelerini oluşturup yeni insanlarla tanışabildiği bir sosyal etkinlik platformudur.

## Özellikler

- **Telefon ile giriş** — SMS/OTP doğrulama, JWT + refresh token
- **Harita üzerinde aktiviteler** — konuma göre yakındaki aktiviteleri listeleme ve kümeleme (PostGIS)
- **Aktivite yönetimi** — oluşturma, düzenleme, kategori, seviye ve cinsiyet tercihi, katılım istekleri
- **Gerçek zamanlı sohbet** — aktivite sohbet odaları (SignalR)
- **Bildirimler** — anlık bildirimler (SignalR)
- **Arkadaşlık** — arkadaşlık istekleri, kullanıcı engelleme
- **Profil ve değerlendirmeler** — profil fotoğrafı, kullanıcı yorumları ve puanları
- **Şikayet sistemi** — kullanıcı ve içerik raporlama
- **Admin paneli** — kullanıcı, aktivite, kategori, şikayet ve yorum yönetimi, dashboard istatistikleri

## Proje Yapısı

```
Sosyolobi/
├── Sosyolobi Backend/    # ASP.NET Core 10 Web API
├── sosyolobi-web-2/      # Next.js web uygulaması (kullanıcı + admin paneli)
└── sosyolobi-mobile/     # Flutter mobil uygulama (Android / iOS)
```

## Teknolojiler

| Katman | Teknoloji |
|---|---|
| Backend | ASP.NET Core 10, Entity Framework Core, SignalR, Swagger |
| Veritabanı | PostgreSQL 16 + PostGIS |
| Önbellek | Redis |
| Web | Next.js 16, React 19, TypeScript, Tailwind CSS 4, TanStack Query, MapLibre |
| Mobil | Flutter, Riverpod, Dio, go_router, MapLibre |
| Altyapı | Docker / Docker Compose |

## Kurulum

### Gereksinimler

- [Docker](https://www.docker.com/) ve Docker Compose
- [.NET 10 SDK](https://dotnet.microsoft.com/) (Docker olmadan çalıştırmak için)
- [Node.js](https://nodejs.org/) 20+
- [Flutter SDK](https://flutter.dev/) 3.x

### 1. Backend

Ortam değişkenlerini hazırlayın (opsiyonel — boş bırakılanlar varsayılan değerlere düşer):

```bash
cd "Sosyolobi Backend"
cp .env.example .env   # JWT_SECRET, PEXELS_API_KEY, POSTGRES_PASSWORD
```

Docker Compose ile veritabanı ve API'yi birlikte başlatın:

```bash
docker compose up -d --build
```

- API: http://localhost:5000
- Swagger: http://localhost:5000/swagger
- PostgreSQL: `localhost:5433`

Migration'lar ve başlangıç verileri uygulama açılışında otomatik uygulanır.

### 2. Web

```bash
cd sosyolobi-web-2
cp .env.example .env.local   # NEXT_PUBLIC_API_URL=http://localhost:5000
npm install
npm run dev
```

Web uygulaması http://localhost:3000 adresinde açılır. Admin paneli `/admin` altındadır.

### 3. Mobil

API adresi `sosyolobi-mobile/env/dev.json` ve `env/prod.json` dosyalarından okunur. Android emülatör için varsayılan değer `http://10.0.2.2:5000`'dir.

```bash
cd sosyolobi-mobile
flutter pub get
flutter run -t lib/main_dev.dart --dart-define-from-file=env/dev.json
```

## Yapılandırma

`appsettings.json` yalnızca varsayılan/yer tutucu değerler içerir. Gerçek gizli bilgiler (JWT anahtarı, Pexels API anahtarı, veritabanı şifresi) ortam değişkenleriyle verilir: Docker ile çalışırken `Sosyolobi Backend/.env`, doğrudan çalıştırırken `Jwt__Secret`, `Pexels__ApiKey` gibi ortam değişkenleri ya da `dotnet user-secrets`. `.env` ve `appsettings.{Environment}.json` dosyaları `.gitignore` ile repoya dahil edilmez.

> **Not:** `Sms:DevelopmentMode` açıkken OTP kodu sabittir (`123456`) ve SMS gönderilmez. Production ortamında kapatılmalıdır.

## Lisans

Bu proje özel bir projedir; tüm hakları saklıdır.
