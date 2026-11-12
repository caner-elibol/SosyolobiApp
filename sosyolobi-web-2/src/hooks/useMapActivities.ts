import { useQuery } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { ActivityMapItem, GenderPreference } from "@/types/user";

interface MapActivitiesParams {
  lat: number;
  lng: number;
  radiusMeters?: number;
  categoryId?: string;
  genderPreference?: GenderPreference;
  isFree?: boolean;
  fromDate?: string;
  toDate?: string;
}

export function useMapActivities(params: MapActivitiesParams | null) {
  return useQuery({
    queryKey: ["map-activities", params],
    queryFn: () => {
      if (!params) return [];
      const qs = new URLSearchParams({
        latitude: String(params.lat),
        longitude: String(params.lng),
        radiusMeters: String(params.radiusMeters ?? 10000),
        ...(params.categoryId ? { categoryId: params.categoryId } : {}),
        ...(params.genderPreference !== undefined ? { genderPreference: String(params.genderPreference) } : {}),
        ...(params.isFree !== undefined ? { isFree: String(params.isFree) } : {}),
        ...(params.fromDate ? { fromDate: params.fromDate } : {}),
        ...(params.toDate ? { toDate: params.toDate } : {}),
      });
      return userApiClient<ActivityMapItem[]>(`/api/activities/map?${qs}`);
    },
    enabled: !!params,
    staleTime: 60_000,
  });
}
