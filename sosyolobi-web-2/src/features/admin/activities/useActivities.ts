import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api-client";
import type { ActivityListItem, AdminActivityDetail, PagedResponse } from "@/types/admin";
import { ActivityStatus } from "@/types/admin";

interface ActivityFilter {
  page?: number;
  pageSize?: number;
  search?: string;
  categoryId?: string;
  status?: ActivityStatus;
}

export function useActivities(filter: ActivityFilter = {}) {
  const params = new URLSearchParams();
  if (filter.page) params.set("page", String(filter.page));
  if (filter.pageSize) params.set("pageSize", String(filter.pageSize));
  if (filter.search) params.set("search", filter.search);
  if (filter.categoryId) params.set("categoryId", filter.categoryId);
  if (filter.status !== undefined) params.set("status", String(filter.status));

  return useQuery({
    queryKey: ["admin", "activities", filter],
    queryFn: () => apiClient<PagedResponse<ActivityListItem>>(`/api/admin/activities?${params}`),
  });
}

export function useActivityDetail(id: string) {
  return useQuery({
    queryKey: ["admin", "activities", id],
    queryFn: () => apiClient<AdminActivityDetail>(`/api/admin/activities/${id}`),
    enabled: !!id,
  });
}

export function useUpdateActivityStatus() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, status }: { id: string; status: ActivityStatus }) =>
      apiClient<null>(`/api/admin/activities/${id}/status`, {
        method: "PATCH",
        body: JSON.stringify({ status }),
      }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["admin", "activities"] });
    },
  });
}
