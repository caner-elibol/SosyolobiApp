import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { ChatUnreadSummary } from "@/types/user";

export function useChatUnread() {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["chat-unread"],
    queryFn: () => userApiClient<ChatUnreadSummary[]>("/api/chat-rooms/unread-summary"),
    refetchInterval: 5_000,
    staleTime: 0,
  });

  const markChatRead = useMutation({
    mutationFn: (roomId: string) =>
      userApiClient<null>(`/api/chat-rooms/${roomId}/read`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["chat-unread"] }),
  });

  const totalUnreadRooms = (query.data ?? []).length;

  return { ...query, markChatRead, totalUnreadRooms };
}
