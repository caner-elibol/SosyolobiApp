"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import { Search, Eye, ShieldOff, ShieldCheck, ShieldAlert } from "lucide-react";
import { ActionMenu } from "@/components/admin/ActionMenu";
import { UserStatusBadge, BooleanBadge } from "@/components/admin/StatusBadge";
import { ConfirmDialog } from "@/components/admin/ConfirmDialog";
import { EmptyState } from "@/components/admin/EmptyState";
import { useUsers, useSuspendUser, useActivateUser, useBanUser } from "@/features/admin/users/useUsers";
import { formatDate } from "@/lib/format";
import { UserStatus, type AdminUserListItem } from "@/types/admin";

const PILL_BASE: React.CSSProperties = {
  height: 34, padding: "0 14px", borderRadius: 8, fontSize: 13,
  fontWeight: 500, cursor: "pointer", border: "none", transition: "all 0.15s",
};

const STATUS_FILTERS = [
  { label: "Tümü", value: undefined },
  { label: "Aktif", value: 1 },
  { label: "Askıda", value: 2 },
  { label: "Banlı", value: 4 },
];

export default function UsersPage() {
  const router = useRouter();
  const [page, setPage] = useState(1);
  const [searchInput, setSearchInput] = useState("");
  const [search, setSearch] = useState("");
  const [status, setStatus] = useState<number | undefined>();
  const [confirm, setConfirm] = useState<{ action: "suspend" | "activate" | "ban"; user: AdminUserListItem } | null>(null);

  const { data, isLoading } = useUsers({ page, pageSize: 20, search, status });
  const suspend = useSuspendUser();
  const activate = useActivateUser();
  const ban = useBanUser();

  async function handleConfirm() {
    if (!confirm) return;
    try {
      if (confirm.action === "suspend") await suspend.mutateAsync(confirm.user.id);
      else if (confirm.action === "activate") await activate.mutateAsync(confirm.user.id);
      else await ban.mutateAsync(confirm.user.id);
      toast.success("İşlem başarılı.");
    } catch { toast.error("İşlem başarısız."); }
    finally { setConfirm(null); }
  }

  const users = data?.items ?? [];

  return (
    <div>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 24 }}>
        <div>
          <h2 style={{ fontSize: 22, fontWeight: 700, color: "#1B1D29" }}>Kullanıcılar</h2>
          <p style={{ fontSize: 13, color: "#6B7280", marginTop: 4 }}>{data?.totalCount ?? 0} kullanıcı kayıtlı</p>
        </div>
      </div>

      <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", padding: "16px 20px", marginBottom: 16 }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12, flexWrap: "wrap" }}>
          <div style={{ position: "relative" }}>
            <Search style={{ position: "absolute", left: 11, top: "50%", transform: "translateY(-50%)", width: 14, height: 14, color: "#6B7280" }} />
            <input
              placeholder="İsim, telefon ara…"
              value={searchInput}
              onChange={(e) => setSearchInput(e.target.value)}
              onKeyDown={(e) => { if (e.key === "Enter") { setSearch(searchInput); setPage(1); } }}
              style={{ height: 36, paddingLeft: 32, paddingRight: 12, borderRadius: 8, border: "1px solid #F0F1F5", fontSize: 13, width: 220, outline: "none", backgroundColor: "#F8F9FF" }}
            />
          </div>
          <div style={{ display: "flex", gap: 6 }}>
            {STATUS_FILTERS.map(({ label, value }) => (
              <button
                key={label}
                onClick={() => { setStatus(value); setPage(1); }}
                style={{
                  ...PILL_BASE,
                  backgroundColor: status === value ? "#5B5FE9" : "#F8F9FF",
                  color: status === value ? "#fff" : "#6B7280",
                }}
              >
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
              {["Kullanıcı", "Tel. Doğrulama", "Puan", "Etkinlik", "Durum", "Kayıt", "Son Giriş", ""].map((h) => (
                <th key={h} style={{ textAlign: "left", padding: "13px 18px", fontSize: 12, fontWeight: 600, color: "#6B7280", backgroundColor: "#FAFBFF", whiteSpace: "nowrap" }}>
                  {h}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {isLoading ? Array.from({ length: 8 }).map((_, i) => (
              <tr key={i} style={{ borderBottom: "1px solid #F8F9FF" }}>
                {Array.from({ length: 8 }).map((_, j) => (
                  <td key={j} style={{ padding: "14px 18px" }}>
                    <div style={{ height: 14, backgroundColor: "#F0F1F5", borderRadius: 6, animation: "pulse 1.5s ease-in-out infinite" }} />
                  </td>
                ))}
              </tr>
            )) : users.map((user, idx) => (
              <tr
                key={user.id}
                style={{ borderBottom: idx < users.length - 1 ? "1px solid #F8F9FF" : "none", cursor: "pointer" }}
                onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = "#FAFBFF")}
                onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = "transparent")}
              >
                <td style={{ padding: "13px 18px" }}>
                  <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
                    <div style={{
                      width: 36, height: 36, borderRadius: "50%",
                      background: "linear-gradient(135deg, #5B5FE9, #7B61FF)",
                      display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0,
                    }}>
                      <span style={{ color: "#fff", fontSize: 13, fontWeight: 700 }}>
                        {(user.displayName || user.phoneNumber)[0].toUpperCase()}
                      </span>
                    </div>
                    <div>
                      <p style={{ fontSize: 14, fontWeight: 600, color: "#1B1D29", lineHeight: 1 }}>{user.displayName || "—"}</p>
                      <p style={{ fontSize: 11, color: "#6B7280", marginTop: 2 }}>{user.phoneNumber.slice(0, 6)}••••••</p>
                    </div>
                  </div>
                </td>
                <td style={{ padding: "13px 18px" }}><BooleanBadge value={user.isPhoneVerified} trueLabel="Doğrulandı" falseLabel="Bekliyor" /></td>
                <td style={{ padding: "13px 18px" }}>
                  <span style={{ fontSize: 13, fontWeight: 600, color: "#B45309" }}>★ {user.averageRating.toFixed(1)}</span>
                  <span style={{ fontSize: 11, color: "#6B7280", marginLeft: 4 }}>({user.reviewCount})</span>
                </td>
                <td style={{ padding: "13px 18px", fontSize: 13, color: "#1B1D29" }}>{user.completedActivityCount}</td>
                <td style={{ padding: "13px 18px" }}><UserStatusBadge status={user.status} /></td>
                <td style={{ padding: "13px 18px", fontSize: 12, color: "#6B7280" }}>{formatDate(user.createdAt)}</td>
                <td style={{ padding: "13px 18px", fontSize: 12, color: "#6B7280" }}>{user.lastLoginAt ? formatDate(user.lastLoginAt) : "—"}</td>
                <td style={{ padding: "13px 18px" }}>
                  <ActionMenu items={[
                    { label: "Detay Gör", icon: Eye, action: () => router.push(`/admin/users/${user.id}`) },
                    ...(user.status !== UserStatus.Suspended ? [{ label: "Askıya Al", icon: ShieldOff, action: () => setConfirm({ action: "suspend", user }) }] : []),
                    ...(user.status === UserStatus.Suspended ? [{ label: "Aktifleştir", icon: ShieldCheck, action: () => setConfirm({ action: "activate", user }) }] : []),
                    ...(user.status !== UserStatus.Banned ? [{ label: "Banla", icon: ShieldAlert, action: () => setConfirm({ action: "ban", user }), danger: true }] : []),
                    ...(user.status === UserStatus.Banned ? [{ label: "Banı Kaldır", icon: ShieldCheck, action: () => setConfirm({ action: "activate", user }) }] : []),
                  ]} />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {!isLoading && users.length === 0 && <EmptyState title="Kullanıcı bulunamadı." description="Filtrelerinizi değiştirip tekrar deneyin." />}
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

      <ConfirmDialog
        open={!!confirm}
        title={confirm?.action === "ban" ? "Kullanıcı banlanacak" : confirm?.action === "suspend" ? "Kullanıcı askıya alınacak" : "Kullanıcı aktifleştirilecek"}
        description="Bu işlemi onaylıyor musunuz?"
        confirmLabel={confirm?.action === "ban" ? "Banla" : confirm?.action === "suspend" ? "Askıya Al" : "Aktifleştir"}
        destructive={confirm?.action === "ban" || confirm?.action === "suspend"}
        onConfirm={handleConfirm}
        onCancel={() => setConfirm(null)}
      />
    </div>
  );
}
