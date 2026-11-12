import { useQuery } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { Activity } from "@/types/user";

interface NearbyParams {
  lat: number;
  lng: number;
  radiusMeters?: number;
  categoryId?: string;
  fromDate?: string;
  toDate?: string;
  page?: number;
}

export function useNearbyActivities(params: NearbyParams | null) {
  return useQuery({
    queryKey: ["nearby-activities", params],
    queryFn: () => {
      if (!params) return [];
      const qs = new URLSearchParams({
        latitude: String(params.lat),
        longitude: String(params.lng),
        radiusMeters: String(params.radiusMeters ?? 10000),
        ...(params.categoryId ? { categoryId: params.categoryId } : {}),
        ...(params.fromDate ? { fromDate: params.fromDate } : {}),
        ...(params.toDate ? { toDate: params.toDate } : {}),
        ...(params.page ? { page: String(params.page) } : {}),
      });
      return userApiClient<Activity[]>(`/api/activities/nearby?${qs}`);
    },
    enabled: !!params,
    staleTime: 30_000,
  });
}
