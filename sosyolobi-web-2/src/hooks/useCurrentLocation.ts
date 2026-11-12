"use client";

import { useState, useEffect, useCallback } from "react";

interface GeoLocation {
  lat: number;
  lng: number;
}

type PermissionState = "prompt" | "granted" | "denied" | "loading";

const CACHE_KEY = "last_known_location";
const CACHE_MAX_AGE_MS = 10 * 60 * 1000;

function readCachedLocation(): GeoLocation | null {
  try {
    const raw = localStorage.getItem(CACHE_KEY);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as GeoLocation & { timestamp: number };
    if (Date.now() - parsed.timestamp > CACHE_MAX_AGE_MS) return null;
    return { lat: parsed.lat, lng: parsed.lng };
  } catch {
    return null;
  }
}

function writeCachedLocation(loc: GeoLocation) {
  try {
    localStorage.setItem(CACHE_KEY, JSON.stringify({ ...loc, timestamp: Date.now() }));
  } catch {
  }
}

export function useCurrentLocation() {
  const [location, setLocation] = useState<GeoLocation | null>(null);
  const [permission, setPermission] = useState<PermissionState>("loading");

  const request = useCallback(() => {
    setPermission("loading");
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        const loc = { lat: pos.coords.latitude, lng: pos.coords.longitude };
        setLocation(loc);
        setPermission("granted");
        writeCachedLocation(loc);
      },
      () => {
        setPermission("denied");
        setLocation({ lat: 41.0082, lng: 28.9784 });
      },
      { enableHighAccuracy: false, timeout: 8000, maximumAge: 60_000 }
    );
  }, []);

  useEffect(() => {
    let cancelled = false;

    const cached = readCachedLocation();
    if (cached) {
      setLocation(cached);
      setPermission("granted");
    }

    if (!navigator.geolocation) {
      setPermission("denied");
      setLocation({ lat: 41.0082, lng: 28.9784 });
      return;
    }
    navigator.permissions
      .query({ name: "geolocation" })
      .then((result) => {
        if (cancelled) return;
        if (result.state === "granted") {
          request();
        } else if (result.state === "denied") {
          setPermission("denied");
          setLocation({ lat: 41.0082, lng: 28.9784 });
        } else {
          setPermission("prompt");
        }
      })
      .catch(() => {
        if (!cancelled) setPermission("prompt");
      });

    return () => {
      cancelled = true;
    };
  }, [request]);

  return { location, permission, request };
}
