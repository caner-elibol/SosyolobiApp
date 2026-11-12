import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { Activity, ActivityDetail } from "@/types/user";

interface CreateActivityPayload {
  categoryId: string;
  title: string;
  description?: string;
  eventDate: string;
  neededPeopleCount: number;
  pricePerPerson?: number;
  skillLevel: number;
  genderPreference: number;
  latitude: number;
  longitude: number;
  addressText: string;
  addressDetailPrivate?: string;
}

export function useCreateActivity() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (payload: CreateActivityPayload) =>
      userApiClient<Activity>("/api/activities", {
        method: "POST",
        body: JSON.stringify(payload),
      }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["nearby-activities"] });
      qc.invalidateQueries({ queryKey: ["map-activities"] });
    },
  });
}

export function useActivity(id: string | null) {
  return useQuery({
    queryKey: ["activity", id],
    queryFn: () => userApiClient<ActivityDetail>(`/api/activities/${id}`),
    enabled: !!id,
    staleTime: 30_000,
  });
}
