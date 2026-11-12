import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api-client";
import type { ReportItem, PagedResponse } from "@/types/admin";
import { ReportStatus } from "@/types/admin";

interface ReportFilter {
  page?: number;
  pageSize?: number;
  status?: ReportStatus;
}

export function useReports(filter: ReportFilter = {}) {
  const params = new URLSearchParams();
  if (filter.page) params.set("page", String(filter.page));
  if (filter.pageSize) params.set("pageSize", String(filter.pageSize));
  if (filter.status !== undefined) params.set("status", String(filter.status));

  return useQuery({
    queryKey: ["admin", "reports", filter],
    queryFn: () => apiClient<PagedResponse<ReportItem>>(`/api/admin/reports?${params}`),
  });
}

export function useReportDetail(id: string) {
  return useQuery({
    queryKey: ["admin", "reports", id],
    queryFn: () => apiClient<ReportItem>(`/api/admin/reports/${id}`),
    enabled: !!id,
  });
}

export function useUpdateReportStatus() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, status, adminNote }: { id: string; status: ReportStatus; adminNote?: string }) =>
      apiClient<null>(`/api/admin/reports/${id}/status`, {
        method: "PATCH",
        body: JSON.stringify({ status, adminNote }),
      }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["admin", "reports"] });
    },
  });
}
