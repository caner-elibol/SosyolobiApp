import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api-client";
import type { AdminUserListItem, AdminUserDetail, PagedResponse } from "@/types/admin";

interface UserFilter {
  page?: number;
  pageSize?: number;
  search?: string;
  status?: number;
  isPhoneVerified?: boolean;
}

export function useUsers(filter: UserFilter = {}) {
  const params = new URLSearchParams();
  if (filter.page) params.set("page", String(filter.page));
  if (filter.pageSize) params.set("pageSize", String(filter.pageSize));
  if (filter.search) params.set("search", filter.search);
  if (filter.status !== undefined) params.set("status", String(filter.status));
  if (filter.isPhoneVerified !== undefined) params.set("isPhoneVerified", String(filter.isPhoneVerified));

  return useQuery({
    queryKey: ["admin", "users", filter],
    queryFn: () => apiClient<PagedResponse<AdminUserListItem>>(`/api/admin/users?${params}`),
  });
}

export function useUserDetail(id: string) {
  return useQuery({
    queryKey: ["admin", "users", id],
    queryFn: () => apiClient<AdminUserDetail>(`/api/admin/users/${id}`),
    enabled: !!id,
  });
}

function useUserAction(action: string) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (id: string) =>
      apiClient<null>(`/api/admin/users/${id}/${action}`, { method: "POST" }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["admin", "users"] });
    },
  });
}

export const useSuspendUser = () => useUserAction("suspend");
export const useActivateUser = () => useUserAction("activate");
export const useBanUser = () => useUserAction("ban");
