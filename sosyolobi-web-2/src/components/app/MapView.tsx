"use client";

import { useCallback, useMemo, useRef, useState } from "react";
import Map, { Marker, Popup, NavigationControl, type MapRef } from "react-map-gl/maplibre";
import Supercluster from "supercluster";
import type { Map as MaplibreMap } from "maplibre-gl";
import "maplibre-gl/dist/maplibre-gl.css";
import { silenceMissingStyleImages } from "@/lib/map-utils";
import { ActivityMarker } from "@/components/app/ActivityMarker";
import { ClusterMarker } from "@/components/app/ClusterMarker";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";
import { resolveImageUrl } from "@/lib/image-url";
import type { ActivityMapItem } from "@/types/user";

const OPENFREEMAP_STYLE = "https://tiles.openfreemap.org/styles/liberty";
const WORLD_BBOX: [number, number, number, number] = [-180, -85, 180, 85];

interface MapViewProps {
  center: { lat: number; lng: number };
  activities: ActivityMapItem[];
  onActivityClick?: (activity: ActivityMapItem) => void;
}

interface PointProps {
  activity: ActivityMapItem;
}

function projectToPixel(lng: number, lat: number, zoom: number) {
  const worldSize = 256 * Math.pow(2, zoom);
  const x = ((lng + 180) / 360) * worldSize;
  const latRad = (lat * Math.PI) / 180;
  const y = (0.5 - Math.log((1 + Math.sin(latRad)) / (1 - Math.sin(latRad))) / (4 * Math.PI)) * worldSize;
  return { x, y };
}

function markerSizeFor(count: number) {
  return count >= 50 ? 56 : count >= 10 ? 48 : 40;
}

const COLLISION_GRID_PX = 46;
const MARKER_GAP_PX = 6;
const MAX_SIDE_BY_SIDE = 5;

function formatDate(iso: string) {
  const d = new Date(iso);
  return d.toLocaleDateString("tr-TR", { day: "numeric", month: "short" }) +
    " " + d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
}

export function MapView({ center, activities, onActivityClick }: MapViewProps) {
  const mapRef = useRef<MapRef>(null);
  const [selected, setSelected] = useState<ActivityMapItem | null>(null);
  const [viewport, setViewport] = useState<{ bbox: [number, number, number, number]; zoom: number }>({
    bbox: WORLD_BBOX,
    zoom: 13,
  });

  const indexesByCategory = useMemo(() => {
    const byCategory: Record<string, ActivityMapItem[]> = {};
    for (const activity of activities) {
      (byCategory[activity.categoryName] ??= []).push(activity);
    }

    const indexes: Record<string, Supercluster<PointProps, object>> = {};
    for (const [categoryName, items] of Object.entries(byCategory)) {
      const sc = new Supercluster<PointProps, object>({ radius: 60, maxZoom: 17 });
      const points: Array<Supercluster.PointFeature<PointProps>> = items.map((activity) => ({
        type: "Feature",
        properties: { activity },
        geometry: { type: "Point", coordinates: [activity.longitude, activity.latitude] },
      }));
      sc.load(points);
      indexes[categoryName] = sc;
    }
    return indexes;
  }, [activities]);

  const { rawClusters, pointFeatures } = useMemo(() => {
    const rawClusters: Array<{ categoryName: string; clusterId: number; count: number; longitude: number; latitude: number }> = [];
    const pointFeatures: Array<{ activity: ActivityMapItem; longitude: number; latitude: number }> = [];
    const zoom = Math.round(viewport.zoom);

    for (const [categoryName, sc] of Object.entries(indexesByCategory)) {
      const features = sc.getClusters(viewport.bbox, zoom);
      for (const feature of features) {
        const [longitude, latitude] = feature.geometry.coordinates;
        if ("cluster" in feature.properties && feature.properties.cluster) {
          const clusterFeature = feature as Supercluster.ClusterFeature<object>;
          rawClusters.push({
            categoryName,
            clusterId: clusterFeature.properties.cluster_id,
            count: clusterFeature.properties.point_count,
            longitude,
            latitude,
          });
        } else {
          const { activity } = (feature as Supercluster.PointFeature<PointProps>).properties;
          pointFeatures.push({ activity, longitude, latitude });
        }
      }
    }
    return { rawClusters, pointFeatures };
  }, [indexesByCategory, viewport]);

  const layoutClusters = useMemo(() => {
    const zoom = viewport.zoom;
    const degLngPerPixel = 360 / (256 * Math.pow(2, zoom));

    const withPixels = rawClusters.map((c) => ({ ...c, ...projectToPixel(c.longitude, c.latitude, zoom) }));

    const grid: Record<string, typeof withPixels> = {};
    for (const c of withPixels) {
      const key = `${Math.round(c.x / COLLISION_GRID_PX)}_${Math.round(c.y / COLLISION_GRID_PX)}`;
      (grid[key] ??= []).push(c);
    }

    const positioned: Array<{
      key: string;
      categoryName?: string;
      isOverflow?: boolean;
      count: number;
      longitude: number;
      latitude: number;
      onClick: () => void;
    }> = [];

    for (const group of Object.values(grid)) {
      group.sort((a, b) => b.count - a.count);
      const visible = group.slice(0, MAX_SIDE_BY_SIDE);
      const overflow = group.slice(MAX_SIDE_BY_SIDE);

      const widths = visible.map((c) => markerSizeFor(c.count));
      if (overflow.length > 0) widths.push(40);
      const totalWidth = widths.reduce((a, b) => a + b, 0) + MARKER_GAP_PX * (widths.length - 1);
      let cursor = -totalWidth / 2;
      const baseLatitude = group[0].latitude;

      visible.forEach((c, i) => {
        const w = widths[i];
        const centerOffsetPx = group.length > 1 ? cursor + w / 2 : 0;
        cursor += w + MARKER_GAP_PX;
        positioned.push({
          key: `cluster-${c.categoryName}-${c.clusterId}`,
          categoryName: c.categoryName,
          count: c.count,
          longitude: c.longitude + centerOffsetPx * degLngPerPixel,
          latitude: baseLatitude,
          onClick: () => handleClusterClick(c.categoryName, c.clusterId, c.longitude, c.latitude),
        });
      });

      if (overflow.length > 0) {
        const w = widths[widths.length - 1];
        const centerOffsetPx = cursor + w / 2;
        const overflowCount = overflow.reduce((sum, c) => sum + c.count, 0);
        const last = overflow[overflow.length - 1];
        positioned.push({
          key: `overflow-${last.categoryName}-${last.clusterId}`,
          isOverflow: true,
          count: overflowCount,
          longitude: group[0].longitude + centerOffsetPx * degLngPerPixel,
          latitude: baseLatitude,
          onClick: () => handleClusterClick(last.categoryName, last.clusterId, last.longitude, last.latitude),
        });
      }
    }

    return positioned;
  }, [rawClusters, viewport.zoom]);

  const syncViewport = useCallback((map: MaplibreMap) => {
    const b = map.getBounds();
    setViewport({
      bbox: [b.getWest(), b.getSouth(), b.getEast(), b.getNorth()],
      zoom: map.getZoom(),
    });
  }, []);

  function handleClusterClick(categoryName: string, clusterId: number, longitude: number, latitude: number) {
    const sc = indexesByCategory[categoryName];
    if (!sc) return;
    const expansionZoom = Math.min(sc.getClusterExpansionZoom(clusterId), 18);
    mapRef.current?.flyTo({ center: [longitude, latitude], zoom: expansionZoom, duration: 500 });
  }

  return (
    <>
    <Map
      ref={mapRef}
      reuseMaps
      onLoad={(e) => {
        silenceMissingStyleImages(e);
        syncViewport(e.target);
      }}
      onMove={(e) => syncViewport(e.target)}
      initialViewState={{
        longitude: center.lng,
        latitude: center.lat,
        zoom: 13,
      }}
      mapStyle={OPENFREEMAP_STYLE}
      style={{ width: "100%", height: "100%" }}
    >
      <NavigationControl position="top-right" />

      <Marker longitude={center.lng} latitude={center.lat} anchor="center">
        <div title="Buradasın" style={{
          position: "relative",
          width: 46,
          height: 46,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}>
          <span className="user-location-pulse" />
          <div style={{
            position: "relative",
            width: 20,
            height: 20,
            background: "var(--color-navy)",
            border: "4px solid #fff",
            borderRadius: "50%",
            boxShadow: "0 2px 10px rgba(0,0,0,0.4)",
            zIndex: 1,
          }} />
        </div>
      </Marker>

      {layoutClusters.map((c) => (
        <Marker key={c.key} longitude={c.longitude} latitude={c.latitude} anchor="center">
          <ClusterMarker count={c.count} categoryName={c.categoryName} isOverflow={c.isOverflow} onClick={c.onClick} />
        </Marker>
      ))}

      {pointFeatures.map(({ activity, longitude, latitude }) => (
        <Marker
          key={activity.id}
          longitude={longitude}
          latitude={latitude}
          anchor="bottom"
          onClick={(e) => {
            e.originalEvent.stopPropagation();
            setSelected(activity);
          }}
        >
          <ActivityMarker
            activity={activity}
            onClick={setSelected}
            selected={selected?.id === activity.id}
          />
        </Marker>
      ))}

      {selected && (
        <Popup
          longitude={selected.longitude}
          latitude={selected.latitude}
          anchor="top"
          onClose={() => setSelected(null)}
          closeButton={false}
          offset={20}
        >
          <ActivityPreview activity={selected} onGoToActivity={() => onActivityClick?.(selected)} />
        </Popup>
      )}
    </Map>
    <style>{`
      .user-location-pulse {
        position: absolute;
        width: 46px;
        height: 46px;
        border-radius: 50%;
        background: rgba(11, 23, 54, 0.35);
        animation: sosyolobi-location-pulse 2.2s ease-out infinite;
      }
      @keyframes sosyolobi-location-pulse {
        0% { transform: scale(0.35); opacity: 0.9; }
        100% { transform: scale(1); opacity: 0; }
      }
    `}</style>
    </>
  );
}

function ActivityPreview({ activity, onGoToActivity }: { activity: ActivityMapItem; onGoToActivity: () => void }) {
  const Icon = getCategoryIcon(activity.categoryName);
  const color = getCategoryColor(activity.categoryName);

  return (
    <div style={{ minWidth: 220, fontFamily: "Inter, ui-sans-serif, system-ui, sans-serif" }}>
      {resolveImageUrl(activity.categoryImageUrl) && (
        <div
          style={{
            height: 90,
            margin: "-10px -10px 8px",
            borderRadius: "var(--radius-sm) var(--radius-sm) 0 0",
            background: `url(${resolveImageUrl(activity.categoryImageUrl)}) center/cover no-repeat`,
          }}
        />
      )}
      <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 6 }}>
        <span style={{
          width: 28,
          height: 28,
          borderRadius: "var(--radius-sm)",
          background: `color-mix(in srgb, ${color} 16%, white)`,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          flexShrink: 0,
        }}>
          <Icon size={15} color={color} />
        </span>
        <p style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)", margin: 0, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
          {activity.title}
        </p>
      </div>
      <p style={{ fontSize: 12, color: "var(--color-muted-foreground)", margin: "0 0 4px" }}>
        {formatDate(activity.eventDate)}
      </p>
      <div style={{ display: "flex", gap: 8, alignItems: "center", marginBottom: 10 }}>
        <span style={{
          fontSize: 11,
          background: "var(--color-accent-soft-bg)",
          color: "var(--color-accent-soft-fg)",
          padding: "2px 6px",
          borderRadius: "var(--radius-sm)",
          fontWeight: 600,
        }}>
          {activity.neededPeopleCount} kişi eksik
        </span>
        {activity.distanceMeters < 1000
          ? <span style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>{Math.round(activity.distanceMeters)} m</span>
          : <span style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>{(activity.distanceMeters / 1000).toFixed(1)} km</span>
        }
      </div>
      <button
        onClick={onGoToActivity}
        style={{
          width: "100%",
          padding: "8px 12px",
          background: "var(--color-accent)",
          color: "#fff",
          border: "none",
          borderRadius: "var(--radius-sm)",
          fontSize: 13,
          fontWeight: 600,
          cursor: "pointer",
        }}
      >
        Etkinliğe Git →
      </button>
    </div>
  );
}
