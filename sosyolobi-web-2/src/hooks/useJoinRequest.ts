import { useMutation, useQueries, useQuery, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { ActivityDetail, ActivityJoinRequest } from "@/types/user";
import { ActivityRequestStatus, ActivityStatus } from "@/types/user";

export function useJoinRequest(activityId: string | null) {
  const qc = useQueryClient();

  const join = useMutation({
    mutationFn: (message?: string) =>
      userApiClient<ActivityJoinRequest>(`/api/activities/${activityId}/requests`, {
        method: "POST",
        body: JSON.stringify({ message }),
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["activity", activityId] }),
  });

  const cancel = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/activity-requests/${requestId}/cancel`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["activity", activityId] }),
  });

  return { join, cancel };
}

export function useIncomingRequests() {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["requests-incoming"],
    queryFn: () => userApiClient<ActivityJoinRequest[]>("/api/activity-requests/incoming"),
    staleTime: 15_000,
  });

  const approve = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/activity-requests/${requestId}/approve`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["requests-incoming"] }),
  });

  const reject = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/activity-requests/${requestId}/reject`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["requests-incoming"] }),
  });

  return { ...query, approve, reject };
}

export function useSentRequests() {
  return useQuery({
    queryKey: ["requests-sent"],
    queryFn: () => userApiClient<ActivityJoinRequest[]>("/api/activity-requests/sent"),
    staleTime: 15_000,
  });
}

export function useMyJoinedActivities() {
  const { data: sent = [], isLoading: sentLoading } = useSentRequests();
  const approvedIds = sent
    .filter((r) => r.status === ActivityRequestStatus.Approved)
    .map((r) => r.activityId);

  const results = useQueries({
    queries: approvedIds.map((id) => ({
      queryKey: ["activity", id],
      queryFn: () => userApiClient<ActivityDetail>(`/api/activities/${id}`),
      staleTime: 30_000,
    })),
  });

  const now = Date.now();
  const data = results
    .map((r) => r.data)
    .filter((a): a is ActivityDetail => !!a)
    .filter(
      (a) =>
        (a.status === ActivityStatus.Open || a.status === ActivityStatus.Full) &&
        new Date(a.eventDate).getTime() >= now
    )
    .sort((a, b) => new Date(a.eventDate).getTime() - new Date(b.eventDate).getTime());

  return { data, isLoading: sentLoading || results.some((r) => r.isLoading) };
}
