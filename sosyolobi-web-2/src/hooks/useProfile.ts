import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { userApiClient } from "@/lib/user-api-client";
import type { PublicProfile, UserProfile } from "@/types/user";

interface UpdateProfilePayload {
  displayName: string;
  bio?: string;
  avatarUrl?: string;
  birthDate?: string;
}

export function useProfile() {
  const qc = useQueryClient();

  const query = useQuery({
    queryKey: ["profile-me"],
    queryFn: () => userApiClient<UserProfile>("/api/profiles/me"),
    staleTime: 60_000,
  });

  const update = useMutation({
    mutationFn: (payload: UpdateProfilePayload) =>
      userApiClient<UserProfile>("/api/profiles/me", {
        method: "PUT",
        body: JSON.stringify(payload),
      }),
    onSuccess: (data) => {
      qc.setQueryData(["profile-me"], data);
    },
  });

  const uploadAvatar = useMutation({
    mutationFn: (file: File) => {
      const formData = new FormData();
      formData.append("file", file);
      return userApiClient<UserProfile>("/api/profiles/me/avatar", {
        method: "POST",
        body: formData,
      });
    },
    onSuccess: (data) => {
      qc.setQueryData(["profile-me"], data);
    },
  });

  return { ...query, update, uploadAvatar };
}

export function usePublicProfile(userId: string | null) {
  return useQuery({
    queryKey: ["public-profile", userId],
    queryFn: () => userApiClient<PublicProfile>(`/api/profiles/${userId}`),
    enabled: !!userId,
    staleTime: 120_000,
  });
}
