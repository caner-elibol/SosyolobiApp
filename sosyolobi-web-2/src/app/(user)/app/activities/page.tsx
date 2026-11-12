"use client";

import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { AppShell } from "@/components/app/AppShell";
import { ActivityCard } from "@/components/app/ActivityCard";
import { FilterChips } from "@/components/app/FilterChips";
import { FilterSelect, FilterToggle } from "@/components/app/FilterSelect";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useCurrentLocation } from "@/hooks/useCurrentLocation";
import { useNearbyActivities } from "@/hooks/useNearbyActivities";
import { userApiClient } from "@/lib/user-api-client";
import { DATE_FILTER_OPTIONS, getDateRange, isWeekendDate, type DateFilterKey } from "@/lib/date-filters";
import type { Category } from "@/types/user";
import { MapPinOff, Search, SearchX } from "lucide-react";

export default function ActivitiesPage() {
  const [search, setSearch] = useState("");
  const { location } = useCurrentLocation();
  const [categoryId, setCategoryId] = useState<string | null>(null);
  const [dateFilter, setDateFilter] = useState<DateFilterKey>("all");
  const [weekendOnly, setWeekendOnly] = useState(false);

  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: () => userApiClient<Category[]>("/api/categories"),
    staleTime: Infinity,
  });

  const { fromDate, toDate } = getDateRange(dateFilter);

  const { data: activities = [], isLoading } = useNearbyActivities(
    location
      ? { lat: location.lat, lng: location.lng, radiusMeters: 10000, fromDate, toDate }
      : null
  );

  const searched = search.trim()
    ? activities.filter((a) => {
        const q = search.toLowerCase();
        return (
          a.title.toLowerCase().includes(q) ||
          a.createdByDisplayName.toLowerCase().includes(q) ||
          a.categoryName.toLowerCase().includes(q) ||
          a.addressText.toLowerCase().includes(q)
        );
      })
    : activities;

  const weekended = weekendOnly ? searched.filter((a) => isWeekendDate(a.eventDate)) : searched;

  const categoryCounts = weekended.reduce<Record<string, number>>((acc, a) => {
    acc[a.categoryId] = (acc[a.categoryId] ?? 0) + 1;
    return acc;
  }, {});

  const filtered = categoryId ? weekended.filter((a) => a.categoryId === categoryId) : weekended;

  return (
    <AppShell>
      <div style={{ maxWidth: 800, margin: "0 auto" }}>
        <div style={{ padding: "16px 16px 12px" }}>
          <div style={{
            display: "flex",
            alignItems: "center",
            gap: 8,
            background: "#F3F4F6",
            borderRadius: "var(--radius-full)",
            padding: "10px 14px",
          }}>
            <Search size={16} color="var(--color-muted-foreground)" style={{ flexShrink: 0 }} />
            <input
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Etkinlik, kategori veya konum ara..."
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
          selected={categoryId}
          onSelect={setCategoryId}
          counts={categoryCounts}
        />

        <div className="no-scrollbar" style={{ display: "flex", gap: 8, overflowX: "auto", padding: "0 16px 12px" }}>
          <FilterSelect
            label="Tarih"
            value={dateFilter}
            onChange={(v) => setDateFilter(v as DateFilterKey)}
            options={DATE_FILTER_OPTIONS}
          />
          <FilterToggle label="Hafta Sonu" active={weekendOnly} onClick={() => setWeekendOnly((v) => !v)} />
        </div>

        <div style={{ padding: "0 16px 24px", display: "flex", flexDirection: "column", gap: 12 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 4 }}>
            <h2 style={{ fontSize: 15, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>
              Yakındaki Etkinlikler
            </h2>
            {!isLoading && <span style={{ fontSize: 13, color: "var(--color-muted-foreground)" }}>{filtered.length} sonuç</span>}
          </div>

          {isLoading && <LoadingState />}
          {!isLoading && !location && (
            <EmptyState icon={MapPinOff} title="Konum gerekli" description="Etkinlikleri görmek için harita sayfasından konum izni verin." />
          )}
          {!isLoading && location && filtered.length === 0 && (
            <EmptyState icon={SearchX} title="Etkinlik bulunamadı" description="Arama kelimesini veya filtreyi değiştirin." />
          )}
          {filtered.map((a) => (
            <ActivityCard key={a.id} activity={a} />
          ))}
        </div>
      </div>
    </AppShell>
  );
}
