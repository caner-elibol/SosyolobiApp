import { useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api-client";
import type { DashboardStats } from "@/types/admin";

export function useDashboardStats() {
  return useQuery({
    queryKey: ["admin", "dashboard", "stats"],
    queryFn: () => apiClient<DashboardStats>("/api/admin/dashboard/stats"),
    staleTime: 60_000,
  });
}
