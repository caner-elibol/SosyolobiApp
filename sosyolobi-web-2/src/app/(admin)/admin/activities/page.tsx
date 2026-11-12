"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import { Search, Eye } from "lucide-react";
import { ActionMenu } from "@/components/admin/ActionMenu";
import { ActivityStatusBadge } from "@/components/admin/StatusBadge";
import { ConfirmDialog } from "@/components/admin/ConfirmDialog";
import { EmptyState } from "@/components/admin/EmptyState";
import { useActivities, useUpdateActivityStatus } from "@/features/admin/activities/useActivities";
import { formatDate } from "@/lib/format";
import { ActivityStatus, type ActivityListItem } from "@/types/admin";

const PILL_BASE: React.CSSProperties = {
  height: 34, padding: "0 14px", borderRadius: 8, fontSize: 13,
  fontWeight: 500, cursor: "pointer", border: "none",
};
const STATUS_FILTERS = [
  { label: "Tümü", value: undefined },
  { label: "Açık", value: ActivityStatus.Open },
  { label: "Dolu", value: ActivityStatus.Full },
  { label: "Tamamlandı", value: ActivityStatus.Completed },
  { label: "İptal", value: ActivityStatus.Cancelled },
];

export default function ActivitiesPage() {
  const router = useRouter();
  const [page, setPage] = useState(1);
  const [searchInput, setSearchInput] = useState("");
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState<ActivityStatus | undefined>();
  const [confirm, setConfirm] = useState<{ action: "cancel" | "complete"; item: ActivityListItem } | null>(null);

  const { data, isLoading } = useActivities({ page, pageSize: 20, search, status: filterStatus });
  const updateStatus = useUpdateActivityStatus();

  async function handleConfirm() {
    if (!confirm) return;
    try {
      await updateStatus.mutateAsync({ id: confirm.item.id, status: confirm.action === "cancel" ? ActivityStatus.Cancelled : ActivityStatus.Completed });
      toast.success("Etkinlik güncellendi.");
    } catch { toast.error("İşlem başarısız."); }
    finally { setConfirm(null); }
  }

  const activities = data?.items ?? [];

  return (
    <div>
      <div style={{ marginBottom: 24 }}>
        <h2 style={{ fontSize: 22, fontWeight: 700, color: "#1B1D29" }}>Etkinlikler</h2>
        <p style={{ fontSize: 13, color: "#6B7280", marginTop: 4 }}>{data?.totalCount ?? 0} etkinlik</p>
      </div>

      <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", padding: "16px 20px", marginBottom: 16 }}>
        <div style={{ display: "flex", gap: 12, flexWrap: "wrap", alignItems: "center" }}>
          <div style={{ position: "relative" }}>
            <Search style={{ position: "absolute", left: 11, top: "50%", transform: "translateY(-50%)", width: 14, height: 14, color: "#6B7280" }} />
            <input placeholder="Etkinlik ara…" value={searchInput}
              onChange={(e) => setSearchInput(e.target.value)}
              onKeyDown={(e) => { if (e.key === "Enter") { setSearch(searchInput); setPage(1); } }}
              style={{ height: 36, paddingLeft: 32, paddingRight: 12, borderRadius: 8, border: "1px solid #F0F1F5", fontSize: 13, width: 200, outline: "none", backgroundColor: "#F8F9FF" }}
            />
          </div>
          <div style={{ display: "flex", gap: 6 }}>
            {STATUS_FILTERS.map(({ label, value }) => (
              <button key={label} onClick={() => { setFilterStatus(value as ActivityStatus | undefined); setPage(1); }}
                style={{ ...PILL_BASE, backgroundColor: filterStatus === value ? "#5B5FE9" : "#F8F9FF", color: filterStatus === value ? "#fff" : "#6B7280" }}>
                {label}
              </button>
            ))}
          </div>
        </div>
      </div>

      <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", overflow: "hidden" }}>
        <table style={{ width: "100%", borderCollapse: "collapse" }}>
          <thead>
            <tr style={{ borderBottom: "1px solid #F0F1F5" }}>
              {["Başlık", "Kategori", "Durum", "Katılım", "Tarih", "Oluşturan", ""].map((h) => (
                <th key={h} style={{ textAlign: "left", padding: "13px 18px", fontSize: 12, fontWeight: 600, color: "#6B7280", backgroundColor: "#FAFBFF", whiteSpace: "nowrap" }}>{h}</th>
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
            )) : activities.map((a, idx) => (
              <tr key={a.id} style={{ borderBottom: idx < activities.length - 1 ? "1px solid #F8F9FF" : "none", cursor: "pointer" }}
                onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = "#FAFBFF")}
                onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = "transparent")}>
                <td style={{ padding: "13px 18px" }}>
                  <p style={{ fontSize: 14, fontWeight: 600, color: "#1B1D29", maxWidth: 200, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{a.title}</p>
                  <p style={{ fontSize: 11, color: "#6B7280", marginTop: 2, maxWidth: 200, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{a.addressText}</p>
                </td>
                <td style={{ padding: "13px 18px" }}>
                  <span style={{ fontSize: 12, backgroundColor: "#EEF0FF", color: "#5B5FE9", padding: "3px 10px", borderRadius: 20, fontWeight: 500 }}>{a.categoryName || "—"}</span>
                </td>
                <td style={{ padding: "13px 18px" }}><ActivityStatusBadge status={a.status} /></td>
                <td style={{ padding: "13px 18px", fontSize: 13, color: "#1B1D29", fontWeight: 500 }}>{a.currentPeopleCount}/{a.neededPeopleCount}</td>
                <td style={{ padding: "13px 18px", fontSize: 12, color: "#6B7280" }}>{formatDate(a.eventDate)}</td>
                <td style={{ padding: "13px 18px", fontSize: 13, color: "#6B7280" }}>{a.createdByDisplayName || "—"}</td>
                <td style={{ padding: "13px 18px" }}>
                  <ActionMenu items={[
                    { label: "Detay Gör", icon: Eye, action: () => router.push(`/admin/activities/${a.id}`) },
                    ...(a.status === ActivityStatus.Open || a.status === ActivityStatus.Full ? [
                      { label: "Tamamlandı", action: () => setConfirm({ action: "complete", item: a }) },
                      { label: "İptal Et", action: () => setConfirm({ action: "cancel", item: a }), danger: true },
                    ] : []),
                  ]} />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {!isLoading && activities.length === 0 && <EmptyState title="Etkinlik bulunamadı." />}
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

      <ConfirmDialog open={!!confirm}
        title={confirm?.action === "cancel" ? "Etkinlik iptal edilsin mi?" : "Tamamlandı olarak işaretlensin mi?"}
        description="Bu işlemi onaylıyor musunuz?"
        confirmLabel={confirm?.action === "cancel" ? "İptal Et" : "Tamamlandı"}
        destructive={confirm?.action === "cancel"}
        onConfirm={handleConfirm} onCancel={() => setConfirm(null)} />
    </div>
  );
}
