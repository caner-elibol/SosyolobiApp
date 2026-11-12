"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useQuery } from "@tanstack/react-query";
import { AppShell } from "@/components/app/AppShell";
import { MapView } from "@/components/app/MapView";
import { ActivityCard } from "@/components/app/ActivityCard";
import { FilterChips } from "@/components/app/FilterChips";
import { FilterSelect, FilterToggle } from "@/components/app/FilterSelect";
import { LocationPermissionCard } from "@/components/app/LocationPermissionCard";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useCurrentLocation } from "@/hooks/useCurrentLocation";
import { useMapActivities } from "@/hooks/useMapActivities";
import { userApiClient } from "@/lib/user-api-client";
import { DATE_FILTER_OPTIONS, getDateRange, isWeekendDate, type DateFilterKey } from "@/lib/date-filters";
import { GenderPreference } from "@/types/user";
import type { Category, ActivityMapItem, Activity } from "@/types/user";
import Link from "next/link";
import { ArrowRight, MapPinned, Search, Users2 } from "lucide-react";

const RADIUS_OPTIONS = [
  { label: "2 km", value: 2000 },
  { label: "5 km", value: 5000 },
  { label: "10 km", value: 10000 },
  { label: "25 km", value: 25000 },
  { label: "50 km", value: 50000 },
];

const GENDER_OPTIONS: { label: string; value: GenderPreference | "all" }[] = [
  { label: "Tümü", value: "all" },
  { label: "Erkek", value: GenderPreference.Male },
  { label: "Kadın", value: GenderPreference.Female },
  { label: "Karışık", value: GenderPreference.Mixed },
];

const PRICE_OPTIONS: { label: string; value: "all" | "free" | "paid" }[] = [
  { label: "Tümü", value: "all" },
  { label: "Ücretsiz", value: "free" },
  { label: "Ücretli", value: "paid" },
];

export default function MapPage() {
  const router = useRouter();
  const { location, permission, request: requestLocation } = useCurrentLocation();
  const [search, setSearch] = useState("");
  const [selectedCategoryId, setSelectedCategoryId] = useState<string | null>(null);
  const [radiusMeters, setRadiusMeters] = useState(10000);
  const [genderFilter, setGenderFilter] = useState<GenderPreference | "all">("all");
  const [priceFilter, setPriceFilter] = useState<"all" | "free" | "paid">("all");
  const [dateFilter, setDateFilter] = useState<DateFilterKey>("all");
  const [weekendOnly, setWeekendOnly] = useState(false);

  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: () => userApiClient<Category[]>("/api/categories"),
    staleTime: Infinity,
  });

  const { fromDate, toDate } = getDateRange(dateFilter);

  const { data: rawMapActivities = [], isLoading } = useMapActivities(
    location
      ? {
          lat: location.lat,
          lng: location.lng,
          radiusMeters,
          genderPreference: genderFilter === "all" ? undefined : genderFilter,
          isFree: priceFilter === "all" ? undefined : priceFilter === "free",
          fromDate,
          toDate,
        }
      : null
  );

  const searched = search.trim()
    ? rawMapActivities.filter((a) => {
        const q = search.toLowerCase();
        return a.title.toLowerCase().includes(q) || a.categoryName.toLowerCase().includes(q);
      })
    : rawMapActivities;

  const weekended = weekendOnly ? searched.filter((a) => isWeekendDate(a.eventDate)) : searched;

  const nameToId = new Map(categories.map((c) => [c.name, c.id]));
  const categoryCounts = weekended.reduce<Record<string, number>>((acc, a) => {
    const id = nameToId.get(a.categoryName);
    if (id) acc[id] = (acc[id] ?? 0) + 1;
    return acc;
  }, {});

  const selectedCategoryName = selectedCategoryId ? categories.find((c) => c.id === selectedCategoryId)?.name : undefined;
  const mapActivities = selectedCategoryName ? weekended.filter((a) => a.categoryName === selectedCategoryName) : weekended;

  function handleMarkerClick(activity: ActivityMapItem) {
    router.push(`/app/activities/${activity.id}`);
  }

  const center = location ?? { lat: 41.0082, lng: 28.9784 };

  const mapBox = permission === "loading" ? (
    <div style={{
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      height: "100%",
      background: "#f0f0f0",
    }}>
      <LoadingState message="Konum alınıyor..." />
    </div>
  ) : (
    <MapView center={center} activities={mapActivities} onActivityClick={handleMarkerClick} />
  );

  return (
    <AppShell fullscreen>
      <div className="map-shell" style={{ display: "flex", flexDirection: "column" }}>

        <div style={{ background: "var(--color-surface)", borderBottom: "1px solid var(--color-border)", flexShrink: 0 }}>
          <div style={{ padding: "12px 16px 8px" }}>
            <div style={{
              display: "flex",
              alignItems: "center",
              gap: 8,
              background: "#F3F4F6",
              borderRadius: "var(--radius-full)",
              padding: "9px 14px",
            }}>
              <Search size={15} color="var(--color-muted-foreground)" style={{ flexShrink: 0 }} />
              <input
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                placeholder="Etkinlik veya kategori ara..."
                style={{
                  flex: 1,
                  border: "none",
                  outline: "none",
                  background: "transparent",
                  fontSize: 14,
                  fontFamily: "inherit",
                  color: "var(--color-foreground)",
                }}
              />
            </div>
          </div>
          <FilterChips
            categories={categories}
            selected={selectedCategoryId}
            onSelect={setSelectedCategoryId}
            counts={categoryCounts}
          />
          <div className="no-scrollbar" style={{ display: "flex", gap: 8, overflowX: "auto", padding: "0 16px 12px" }}>
            <FilterSelect
              label="Mesafe"
              value={String(radiusMeters)}
              onChange={(v) => setRadiusMeters(Number(v))}
              options={RADIUS_OPTIONS.map((o) => ({ label: o.label, value: String(o.value) }))}
            />
            <FilterSelect
              label="Tarih"
              value={dateFilter}
              onChange={(v) => setDateFilter(v as DateFilterKey)}
              options={DATE_FILTER_OPTIONS}
            />
            <FilterToggle label="Hafta Sonu" active={weekendOnly} onClick={() => setWeekendOnly((v) => !v)} />
            <FilterSelect
              label="Kimler"
              value={String(genderFilter)}
              onChange={(v) => setGenderFilter(v === "all" ? "all" : (Number(v) as GenderPreference))}
              options={GENDER_OPTIONS.map((o) => ({ label: o.label, value: String(o.value) }))}
            />
            <FilterSelect
              label="Ücret"
              value={priceFilter}
              onChange={(v) => setPriceFilter(v as "all" | "free" | "paid")}
              options={PRICE_OPTIONS.map((o) => ({ label: o.label, value: o.value }))}
            />
          </div>
        </div>

        {permission === "prompt" && (
          <div style={{ padding: "12px 16px", background: "var(--color-surface)", flexShrink: 0 }}>
            <LocationPermissionCard
              onAllow={requestLocation}
              onDismiss={() => {}}
            />
          </div>
        )}

        <div className="show-mobile" style={{ flexDirection: "column", padding: 16, gap: 16 }}>
          <div style={{ height: 200, borderRadius: "var(--radius-lg)", overflow: "hidden", position: "relative", flexShrink: 0 }}>
            {mapBox}
          </div>

          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
            <h2 style={{ fontSize: 16, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>
              Yakındaki Etkinlikler
            </h2>
            {mapActivities.length > 0 && (
              <Link href="/app/activities" style={{ display: "inline-flex", alignItems: "center", gap: 4, fontSize: 13, fontWeight: 600, color: "var(--color-accent)", textDecoration: "none" }}>
                Tümünü Gör <ArrowRight size={13} />
              </Link>
            )}
          </div>

          {isLoading && <LoadingState message="Etkinlikler aranıyor..." />}
          {!isLoading && mapActivities.length === 0 && (
            <EmptyState icon={MapPinned} title="Yakında etkinlik bulunamadı" description="Arama yarıçapını artırın veya filtre kaldırın." />
          )}
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            {mapActivities.map((a) => (
              <ActivityCard key={a.id} activity={a as unknown as Activity} variant="vertical" />
            ))}
          </div>

          <PromoCard />
        </div>

        <div className="hidden-mobile" style={{ flex: 1, overflow: "hidden" }}>
          <div
            style={{
              width: 420,
              flexShrink: 0,
              overflowY: "auto",
              borderRight: "1px solid var(--color-border)",
              background: "var(--color-background)",
              padding: "16px",
              display: "flex",
              flexDirection: "column",
              gap: 12,
            }}
          >
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
              <h2 style={{ fontSize: 16, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>
                Yakındaki Etkinlikler
              </h2>
              <span style={{ fontSize: 13, color: "var(--color-muted-foreground)" }}>{mapActivities.length} etkinlik</span>
            </div>

            {isLoading && <LoadingState message="Etkinlikler aranıyor..." />}
            {!isLoading && mapActivities.length === 0 && (
              <EmptyState
                icon={MapPinned}
                title="Yakında etkinlik bulunamadı"
                description="Arama yarıçapını artırın veya filtre kaldırın."
              />
            )}
            {mapActivities.slice(0, 8).map((a) => (
              <ActivityCard key={a.id} activity={a as unknown as Activity} compact />
            ))}

            {mapActivities.length > 0 && (
              <Link href="/app/activities" style={{
                display: "inline-flex",
                alignItems: "center",
                gap: 6,
                fontSize: 13,
                fontWeight: 600,
                color: "var(--color-accent)",
                textDecoration: "none",
                padding: "4px 2px",
              }}>
                Tüm Etkinlikleri Gör <ArrowRight size={14} />
              </Link>
            )}

            <PromoCard />
          </div>

          <div style={{ flex: 1, position: "relative" }}>
            {mapBox}
          </div>
        </div>
      </div>

      <style>{`
        @media (max-width: 767px) {
          .show-mobile { display: flex !important; }
        }
        @media (min-width: 768px) {
          .show-mobile { display: none !important; }
          .map-shell { height: calc(100vh - 60px); }
        }
      `}</style>
    </AppShell>
  );
}

function PromoCard() {
  return (
    <Link href="/app/activities/create" style={{
      display: "flex",
      alignItems: "center",
      gap: 14,
      padding: 18,
      borderRadius: "var(--radius-lg)",
      background: "var(--gradient-promo)",
      textDecoration: "none",
      flexShrink: 0,
    }}>
      <span style={{
        width: 40,
        height: 40,
        borderRadius: "50%",
        background: "rgba(255,255,255,0.12)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        flexShrink: 0,
      }}>
        <Users2 size={20} color="#fff" />
      </span>
      <div style={{ flex: 1, minWidth: 0 }}>
        <p style={{ color: "#fff", fontSize: 14, fontWeight: 700, margin: "0 0 2px" }}>
          Etkinlik oluştur, insanları bir araya getir!
        </p>
        <p style={{ color: "rgba(255,255,255,0.65)", fontSize: 12, margin: 0 }}>
          Kendi etkinliğini oluştur ve topluluğunu büyüt.
        </p>
      </div>
      <span style={{
        display: "inline-flex",
        alignItems: "center",
        gap: 6,
        padding: "9px 14px",
        borderRadius: "var(--radius-full)",
        background: "var(--gradient-cta)",
        color: "#fff",
        fontSize: 12,
        fontWeight: 700,
        whiteSpace: "nowrap",
        flexShrink: 0,
      }}>
        Oluştur <ArrowRight size={13} />
      </span>
    </Link>
  );
}
