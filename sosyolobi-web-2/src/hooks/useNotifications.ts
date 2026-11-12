import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { Notification } from "@/types/user";

export function useNotifications() {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["notifications"],
    queryFn: () => userApiClient<Notification[]>("/api/notifications"),
    refetchInterval: 5_000,
    staleTime: 0,
  });

  const markRead = useMutation({
    mutationFn: (id: string) =>
      userApiClient<null>(`/api/notifications/${id}/read`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["notifications"] }),
  });

  const markAllRead = useMutation({
    mutationFn: () =>
      userApiClient<null>("/api/notifications/read-all", { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["notifications"] }),
  });

  const unreadCount = (query.data ?? []).filter((n) => !n.isRead).length;

  return { ...query, markRead, markAllRead, unreadCount };
}
