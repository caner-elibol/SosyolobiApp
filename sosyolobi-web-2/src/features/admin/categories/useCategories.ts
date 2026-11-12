import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api-client";
import type { AdminCategoryItem, AdminCategoryRequest } from "@/types/admin";

export function useCategories() {
  return useQuery({
    queryKey: ["admin", "categories"],
    queryFn: () => apiClient<AdminCategoryItem[]>("/api/admin/categories"),
  });
}

export function useCreateCategory() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (data: AdminCategoryRequest) =>
      apiClient<AdminCategoryItem>("/api/admin/categories", {
        method: "POST",
        body: JSON.stringify(data),
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["admin", "categories"] }),
  });
}

export function useUpdateCategory() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, data }: { id: string; data: AdminCategoryRequest }) =>
      apiClient<null>(`/api/admin/categories/${id}`, {
        method: "PUT",
        body: JSON.stringify(data),
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["admin", "categories"] }),
  });
}

export function useUpdateCategoryStatus() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, isActive }: { id: string; isActive: boolean }) =>
      apiClient<null>(`/api/admin/categories/${id}/status`, {
        method: "PATCH",
        body: JSON.stringify(isActive),
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["admin", "categories"] }),
  });
}

export function useUploadCategoryImage() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, file }: { id: string; file: File }) => {
      const formData = new FormData();
      formData.append("File", file);
      return apiClient<AdminCategoryItem>(`/api/admin/categories/${id}/image`, {
        method: "POST",
        body: formData,
      });
    },
    onSuccess: () => qc.invalidateQueries({ queryKey: ["admin", "categories"] }),
  });
}

export function useRemoveCategoryImage() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (id: string) =>
      apiClient<AdminCategoryItem>(`/api/admin/categories/${id}/image`, {
        method: "DELETE",
      }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["admin", "categories"] }),
  });
}
