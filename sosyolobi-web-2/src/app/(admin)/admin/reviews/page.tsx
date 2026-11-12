"use client";

import { useState } from "react";
import { toast } from "sonner";
import { Star, Eye, EyeOff } from "lucide-react";
import { EmptyState } from "@/components/admin/EmptyState";
import { useReviews, useUpdateReviewVisibility } from "@/features/admin/reviews/useReviews";
import { formatDateTime } from "@/lib/format";

const PILL_BASE: React.CSSProperties = {
  height: 34, padding: "0 14px", borderRadius: 8, fontSize: 13,
  fontWeight: 500, cursor: "pointer", border: "none",
};

function Stars({ rating }: { rating: number }) {
  return (
    <div style={{ display: "flex", gap: 2 }}>
      {Array.from({ length: 5 }).map((_, i) => (
        <Star key={i} size={13} style={{ fill: i < rating ? "#FFC542" : "none", color: i < rating ? "#FFC542" : "#D1D5DB" }} />
      ))}
    </div>
  );
}

export default function ReviewsPage() {
  const [page, setPage] = useState(1);
  const { data, isLoading } = useReviews(page, 20);
  const updateVisibility = useUpdateReviewVisibility();

  async function toggleVisibility(id: string, isHidden: boolean) {
    try {
      await updateVisibility.mutateAsync({ id, isHidden: !isHidden });
      toast.success(isHidden ? "Yorum görünür yapıldı." : "Yorum gizlendi.");
    } catch { toast.error("İşlem başarısız."); }
  }

  const reviews = data?.items ?? [];

  return (
    <div>
      <div style={{ marginBottom: 24 }}>
        <h2 style={{ fontSize: 22, fontWeight: 700, color: "#1B1D29" }}>Yorumlar</h2>
        <p style={{ fontSize: 13, color: "#6B7280", marginTop: 4 }}>{data?.totalCount ?? 0} yorum</p>
      </div>

      <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", overflow: "hidden" }}>
        <table style={{ width: "100%", borderCollapse: "collapse" }}>
          <thead>
            <tr style={{ borderBottom: "1px solid #F0F1F5" }}>
              {["Yorum Yapan", "Yorum Alan", "Etkinlik", "Puan", "Yorum", "Tarih", ""].map((h) => (
                <th key={h} style={{ textAlign: "left", padding: "13px 18px", fontSize: 12, fontWeight: 600, color: "#6B7280", backgroundColor: "#FAFBFF" }}>{h}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {isLoading ? Array.from({ length: 8 }).map((_, i) => (
              <tr key={i} style={{ borderBottom: "1px solid #F8F9FF" }}>
                {Array.from({ length: 7 }).map((_, j) => (
                  <td key={j} style={{ padding: "14px 18px" }}>
                    <div style={{ height: 14, backgroundColor: "#F0F1F5", borderRadius: 6, animation: "pulse 1.5s ease-in-out infinite" }} />
                  </td>
                ))}
              </tr>
            )) : reviews.map((r, idx) => (
              <tr key={r.id}
                style={{ borderBottom: idx < reviews.length - 1 ? "1px solid #F8F9FF" : "none", opacity: r.isHidden ? 0.5 : 1 }}
                onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = "#FAFBFF")}
                onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = "transparent")}>
                <td style={{ padding: "13px 18px" }}>
                  <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
                    <div style={{ width: 32, height: 32, borderRadius: "50%", background: "linear-gradient(135deg, #5B5FE9, #7B61FF)", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
                      <span style={{ color: "#fff", fontSize: 12, fontWeight: 700 }}>{r.reviewerDisplayName[0]?.toUpperCase()}</span>
                    </div>
                    <span style={{ fontSize: 14, fontWeight: 600, color: "#1B1D29" }}>{r.reviewerDisplayName}</span>
                  </div>
                </td>
                <td style={{ padding: "13px 18px", fontSize: 13, color: "#6B7280" }}>{r.reviewedDisplayName}</td>
                <td style={{ padding: "13px 18px" }}>
                  <p style={{ fontSize: 13, color: "#6B7280", maxWidth: 160, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.activityTitle}</p>
                </td>
                <td style={{ padding: "13px 18px" }}><Stars rating={r.rating} /></td>
                <td style={{ padding: "13px 18px" }}>
                  <p style={{ fontSize: 13, color: "#1B1D29", maxWidth: 200, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.comment || "—"}</p>
                </td>
                <td style={{ padding: "13px 18px", fontSize: 12, color: "#6B7280" }}>{formatDateTime(r.createdAt)}</td>
                <td style={{ padding: "13px 18px" }}>
                  <button
                    onClick={() => toggleVisibility(r.id, r.isHidden)}
                    style={{
                      display: "flex", alignItems: "center", gap: 5, height: 30, padding: "0 12px",
                      borderRadius: 8, border: "1px solid #F0F1F5", backgroundColor: "#fff",
                      fontSize: 12, fontWeight: 500, cursor: "pointer",
                      color: r.isHidden ? "#15803D" : "#6B7280",
                    }}
                  >
                    {r.isHidden ? <><Eye size={12} /> Göster</> : <><EyeOff size={12} /> Gizle</>}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {!isLoading && reviews.length === 0 && <EmptyState icon={Star} title="Henüz yorum yok." />}
      </div>

      {data && data.totalPages > 1 && (
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginTop: 16 }}>
          <span style={{ fontSize: 13, color: "#6B7280" }}>{data.totalCount} kayıt — sayfa {page} / {data.totalPages}</span>
          <div style={{ display: "flex", gap: 8 }}>
            <button disabled={!data.hasPreviousPage} onClick={() => setPage((p) => p - 1)} style={{ ...PILL_BASE, backgroundColor: "#fff", color: "#1B1D29", border: "1px solid #F0F1F5", opacity: data.hasPreviousPage ? 1 : 0.4 }}>← Önceki</button>
            <button disabled={!data.hasNextPage} onClick={() => setPage((p) => p + 1)} style={{ ...PILL_BASE, backgroundColor: "#5B5FE9", color: "#fff", opacity: data.hasNextPage ? 1 : 0.4 }}>Sonraki →</button>
          </div>
        </div>
      )}
    </div>
  );
}
