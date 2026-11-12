import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api-client";
import type { AdminReviewItem, PagedResponse } from "@/types/admin";

export function useReviews(page = 1, pageSize = 20) {
  return useQuery({
    queryKey: ["admin", "reviews", page, pageSize],
    queryFn: () =>
      apiClient<PagedResponse<AdminReviewItem>>(
        `/api/admin/reviews?page=${page}&pageSize=${pageSize}`
      ),
  });
}

export function useUpdateReviewVisibility() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, isHidden }: { id: string; isHidden: boolean }) =>
      apiClient<null>(`/api/admin/reviews/${id}/visibility`, {
        method: "PATCH",
        body: JSON.stringify({ isHidden }),
      }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["admin", "reviews"] });
    },
  });
}
