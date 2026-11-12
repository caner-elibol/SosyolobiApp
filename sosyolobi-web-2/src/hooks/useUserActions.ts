import { useMutation } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";

export function useBlockUser() {
  return useMutation({
    mutationFn: (userId: string) =>
      userApiClient<null>(`/api/users/${userId}/block`, { method: "POST" }),
  });
}

export function useUnblockUser() {
  return useMutation({
    mutationFn: (userId: string) =>
      userApiClient<null>(`/api/users/${userId}/block`, { method: "DELETE" }),
  });
}

interface ReportUserPayload {
  reportedUserId: string;
  reason: string;
  details?: string;
}

export function useReportUser() {
  return useMutation({
    mutationFn: (payload: ReportUserPayload) =>
      userApiClient<unknown>("/api/reports", {
        method: "POST",
        body: JSON.stringify(payload),
      }),
  });
}
