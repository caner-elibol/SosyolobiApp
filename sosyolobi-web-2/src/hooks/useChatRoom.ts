import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { ChatMessage, ChatRoom, PagedResponse } from "@/types/user";

export function useChatRoom(activityId: string | null) {
  return useQuery({
    queryKey: ["chat-room", activityId],
    queryFn: () => userApiClient<ChatRoom>(`/api/activities/${activityId}/chat-room`),
    enabled: !!activityId,
    staleTime: 30_000,
  });
}

export function useChatMessages(roomId: string | null) {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["chat-messages", roomId],
    queryFn: () =>
      userApiClient<PagedResponse<ChatMessage>>(`/api/chat-rooms/${roomId}/messages?page=1&pageSize=50`),
    enabled: !!roomId,
    staleTime: 0,
  });

  const sendMessage = useMutation({
    mutationFn: (payload: { content: string; replyToMessageId?: string }) =>
      userApiClient<ChatMessage>(`/api/chat-rooms/${roomId}/messages`, {
        method: "POST",
        body: JSON.stringify(payload),
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["chat-messages", roomId] }),
  });

  return { ...query, sendMessage };
}
