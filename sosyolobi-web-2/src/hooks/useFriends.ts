import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { Activity, Friend, FriendRequest } from "@/types/user";

export function useFriends() {
  return useQuery({
    queryKey: ["friends"],
    queryFn: () => userApiClient<Friend[]>("/api/friends"),
    staleTime: 30_000,
  });
}

export function useRemoveFriend() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (friendUserId: string) =>
      userApiClient<null>(`/api/friends/${friendUserId}`, { method: "DELETE" }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["friends"] });
      qc.invalidateQueries({ queryKey: ["friend-status"] });
    },
  });
}

export function useFriendActivities(userId: string | null) {
  return useQuery({
    queryKey: ["friend-activities", userId],
    queryFn: () => userApiClient<Activity[]>(`/api/friends/${userId}/activities`),
    enabled: !!userId,
    staleTime: 30_000,
    retry: false,
  });
}

export function useIncomingFriendRequests() {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["friend-requests-incoming"],
    queryFn: () => userApiClient<FriendRequest[]>("/api/friends/requests/incoming"),
    staleTime: 15_000,
  });

  const accept = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/friends/requests/${requestId}/accept`, { method: "POST" }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["friend-requests-incoming"] });
      qc.invalidateQueries({ queryKey: ["friends"] });
      qc.invalidateQueries({ queryKey: ["friend-status"] });
    },
  });

  const reject = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/friends/requests/${requestId}/reject`, { method: "POST" }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["friend-requests-incoming"] }),
  });

  return { ...query, accept, reject };
}

export function useSentFriendRequests() {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["friend-requests-sent"],
    queryFn: () => userApiClient<FriendRequest[]>("/api/friends/requests/sent"),
    staleTime: 15_000,
  });

  const cancel = useMutation({
    mutationFn: (requestId: string) =>
      userApiClient<null>(`/api/friends/requests/${requestId}`, { method: "DELETE" }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["friend-requests-sent"] });
      qc.invalidateQueries({ queryKey: ["friend-status"] });
    },
  });

  return { ...query, cancel };
}

export function useSendFriendRequest() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (addresseeUserId: string) =>
      userApiClient<FriendRequest>("/api/friends/requests", {
        method: "POST",
        body: JSON.stringify({ addresseeUserId }),
      }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["friend-requests-sent"] });
      qc.invalidateQueries({ queryKey: ["friend-status"] });
    },
  });
}

export function useFriendStatus(userId: string | null) {
  const { data: friends = [], isLoading: friendsLoading } = useFriends();
  const { data: sent = [], isLoading: sentLoading } = useSentFriendRequests();
  const { data: incoming = [], isLoading: incomingLoading } = useIncomingFriendRequests();

  if (!userId) return { status: "none" as const, isLoading: false };

  const friend = friends.find((f) => f.user.userId === userId);
  if (friend) return { status: "friends" as const, isLoading: false, friend };

  const sentRequest = sent.find((r) => r.user.userId === userId);
  if (sentRequest) return { status: "pending-sent" as const, isLoading: false, request: sentRequest };

  const incomingRequest = incoming.find((r) => r.user.userId === userId);
  if (incomingRequest) return { status: "pending-incoming" as const, isLoading: false, request: incomingRequest };

  return { status: "none" as const, isLoading: friendsLoading || sentLoading || incomingLoading };
}
