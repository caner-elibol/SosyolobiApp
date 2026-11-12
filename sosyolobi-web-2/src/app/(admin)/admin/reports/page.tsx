"use client";

import { useState } from "react";
import { toast } from "sonner";
import { Flag } from "lucide-react";
import { ActionMenu } from "@/components/admin/ActionMenu";
import { ReportStatusBadge } from "@/components/admin/StatusBadge";
import { ConfirmDialog } from "@/components/admin/ConfirmDialog";
import { EmptyState } from "@/components/admin/EmptyState";
import { useReports, useUpdateReportStatus } from "@/features/admin/reports/useReports";
import { formatDateTime } from "@/lib/format";
import { ReportStatus, type ReportItem } from "@/types/admin";

const PILL_BASE: React.CSSProperties = {
  height: 34, padding: "0 14px", borderRadius: 8, fontSize: 13,
  fontWeight: 500, cursor: "pointer", border: "none",
};

const STATUS_FILTERS = [
  { label: "Tümü", value: undefined },
  { label: "Bekliyor", value: ReportStatus.Pending },
  { label: "İnceleniyor", value: ReportStatus.Reviewing },
  { label: "Çözüldü", value: ReportStatus.Resolved },
  { label: "Reddedildi", value: ReportStatus.Dismissed },
];

export default function ReportsPage() {
  const [page, setPage] = useState(1);
  const [filterStatus, setFilterStatus] = useState<ReportStatus | undefined>();
  const [confirm, setConfirm] = useState<{ action: "reviewing" | "resolve" | "dismiss"; report: ReportItem } | null>(null);

  const { data, isLoading } = useReports({ page, pageSize: 20, status: filterStatus });
  const updateStatus = useUpdateReportStatus();

  async function handleConfirm() {
    if (!confirm) return;
    const statusMap = { reviewing: ReportStatus.Reviewing, resolve: ReportStatus.Resolved, dismiss: ReportStatus.Dismissed };
    try {
      await updateStatus.mutateAsync({ id: confirm.report.id, status: statusMap[confirm.action] });
      toast.success("Rapor durumu güncellendi.");
    } catch { toast.error("İşlem başarısız."); }
    finally { setConfirm(null); }
  }

  const reports = data?.items ?? [];

  return (
    <div>
      <div style={{ marginBottom: 24 }}>
        <h2 style={{ fontSize: 22, fontWeight: 700, color: "#1B1D29" }}>Şikayetler</h2>
        <p style={{ fontSize: 13, color: "#6B7280", marginTop: 4 }}>{data?.totalCount ?? 0} şikayet</p>
      </div>

      <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", padding: "14px 20px", marginBottom: 16 }}>
        <div style={{ display: "flex", gap: 6, flexWrap: "wrap" }}>
          {STATUS_FILTERS.map(({ label, value }) => (
            <button key={label} onClick={() => { setFilterStatus(value); setPage(1); }}
              style={{ ...PILL_BASE, backgroundColor: filterStatus === value ? "#5B5FE9" : "#F8F9FF", color: filterStatus === value ? "#fff" : "#6B7280" }}>
              {label}
            </button>
          ))}
        </div>
      </div>

      <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", overflow: "hidden" }}>
        <table style={{ width: "100%", borderCollapse: "collapse" }}>
          <thead>
            <tr style={{ borderBottom: "1px solid #F0F1F5" }}>
              {["Sebep", "Tür", "Detay", "Durum", "Tarih", ""].map((h) => (
                <th key={h} style={{ textAlign: "left", padding: "13px 18px", fontSize: 12, fontWeight: 600, color: "#6B7280", backgroundColor: "#FAFBFF" }}>{h}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {isLoading ? Array.from({ length: 8 }).map((_, i) => (
              <tr key={i} style={{ borderBottom: "1px solid #F8F9FF" }}>
                {Array.from({ length: 6 }).map((_, j) => (
                  <td key={j} style={{ padding: "14px 18px" }}>
                    <div style={{ height: 14, backgroundColor: "#F0F1F5", borderRadius: 6, animation: "pulse 1.5s ease-in-out infinite" }} />
                  </td>
                ))}
              </tr>
            )) : reports.map((r, idx) => (
              <tr key={r.id} style={{ borderBottom: idx < reports.length - 1 ? "1px solid #F8F9FF" : "none" }}
                onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = "#FAFBFF")}
                onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = "transparent")}>
                <td style={{ padding: "13px 18px", fontSize: 14, fontWeight: 600, color: "#1B1D29" }}>{r.reason}</td>
                <td style={{ padding: "13px 18px" }}>
                  <span style={{ fontSize: 12, backgroundColor: r.reportedUserId ? "#E7F1FF" : "#EFEAFE", color: r.reportedUserId ? "#1D4ED8" : "#5B21B6", padding: "3px 10px", borderRadius: 20, fontWeight: 500 }}>
                    {r.reportedUserId ? "Kullanıcı" : "Etkinlik"}
                  </span>
                </td>
                <td style={{ padding: "13px 18px" }}>
                  <p style={{ fontSize: 13, color: "#6B7280", maxWidth: 240, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.details || "—"}</p>
                </td>
                <td style={{ padding: "13px 18px" }}><ReportStatusBadge status={r.status} /></td>
                <td style={{ padding: "13px 18px", fontSize: 12, color: "#6B7280" }}>{formatDateTime(r.createdAt)}</td>
                <td style={{ padding: "13px 18px" }}>
                  <ActionMenu items={[
                    ...(r.status === ReportStatus.Pending ? [{ label: "İncelemeye Al", action: () => setConfirm({ action: "reviewing", report: r }) }] : []),
                    ...(r.status !== ReportStatus.Resolved ? [{ label: "Çözüldü", action: () => setConfirm({ action: "resolve", report: r }) }] : []),
                    ...(r.status !== ReportStatus.Dismissed ? [{ label: "Reddet", action: () => setConfirm({ action: "dismiss", report: r }), danger: true }] : []),
                  ]} />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {!isLoading && reports.length === 0 && <EmptyState icon={Flag} title="Bekleyen şikayet yok." />}
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
        title={confirm?.action === "reviewing" ? "İncelemeye alınsın mı?" : confirm?.action === "resolve" ? "Çözüldü işaretlensin mi?" : "Şikayet reddedilsin mi?"}
        description="Bu işlemi onaylıyor musunuz?"
        confirmLabel={confirm?.action === "reviewing" ? "İncelemeye Al" : confirm?.action === "resolve" ? "Çözüldü" : "Reddet"}
        destructive={confirm?.action === "dismiss"}
        onConfirm={handleConfirm} onCancel={() => setConfirm(null)} />
    </div>
  );
}
