"use client";

import { useParams, useRouter } from "next/navigation";
import { toast } from "sonner";
import {
  ArrowLeft, Phone, Mail, Star, Calendar, Flag,
  ShieldOff, ShieldAlert, ShieldCheck, CheckCircle, Clock,
} from "lucide-react";
import { UserStatusBadge, BooleanBadge } from "@/components/admin/StatusBadge";
import { ConfirmDialog } from "@/components/admin/ConfirmDialog";
import { useUserDetail, useSuspendUser, useActivateUser, useBanUser } from "@/features/admin/users/useUsers";
import { formatDate, formatDateTime, ACTIVITY_STATUS_LABEL } from "@/lib/format";
import { UserStatus } from "@/types/admin";
import { useState } from "react";

const C = {
  purple: "#5B5FE9",
  purpleLight: "#EEF0FF",
  pageBg: "#F4F5F9",
  cardBg: "#FFFFFF",
  cardBorder: "#F0F1F5",
  textDark: "#1B1D29",
  textMuted: "#6B7280",
};

function Card({ children, style }: { children: React.ReactNode; style?: React.CSSProperties }) {
  return (
    <div style={{
      backgroundColor: C.cardBg,
      border: `1px solid ${C.cardBorder}`,
      borderRadius: 16,
      ...style,
    }}>
      {children}
    </div>
  );
}

function SectionTitle({ children }: { children: React.ReactNode }) {
  return (
    <p style={{ fontSize: 15, fontWeight: 700, color: C.textDark, marginBottom: 16, padding: "20px 20px 0" }}>
      {children}
    </p>
  );
}

function StatBubble({ label, value, color = C.purple }: { label: string; value: string | number; color?: string }) {
  return (
    <div style={{ textAlign: "center", flex: 1 }}>
      <p style={{ fontSize: 26, fontWeight: 800, color, lineHeight: 1 }}>{value}</p>
      <p style={{ fontSize: 12, color: C.textMuted, marginTop: 4 }}>{label}</p>
    </div>
  );
}

type ConfirmAction = "suspend" | "activate" | "ban";

export default function UserDetailPage() {
  const { id } = useParams<{ id: string }>();
  const router = useRouter();
  const { data: user, isLoading } = useUserDetail(id);
  const suspend = useSuspendUser();
  const activate = useActivateUser();
  const ban = useBanUser();
  const [confirm, setConfirm] = useState<ConfirmAction | null>(null);

  async function handleConfirm() {
    if (!confirm || !user) return;
    try {
      if (confirm === "suspend") await suspend.mutateAsync(user.id);
      else if (confirm === "activate") await activate.mutateAsync(user.id);
      else await ban.mutateAsync(user.id);
      toast.success("İşlem başarılı.");
    } catch { toast.error("İşlem başarısız."); }
    finally { setConfirm(null); }
  }

  if (isLoading) {
    return (
      <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
        {Array.from({ length: 3 }).map((_, i) => (
          <div key={i} style={{ height: 120, backgroundColor: C.cardBg, borderRadius: 16, border: `1px solid ${C.cardBorder}`, animation: "pulse 1.5s ease-in-out infinite" }} />
        ))}
      </div>
    );
  }

  if (!user) {
    return (
      <div style={{ textAlign: "center", paddingTop: 80 }}>
        <p style={{ color: C.textMuted }}>Kullanıcı bulunamadı.</p>
      </div>
    );
  }

  const initials = (user.displayName || user.phoneNumber).slice(0, 2).toUpperCase();

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>

      <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 4 }}>
        <button
          onClick={() => router.push("/admin/users")}
          style={{ display: "flex", alignItems: "center", gap: 6, color: C.textMuted, fontSize: 13, background: "none", border: "none", cursor: "pointer", padding: 0 }}
        >
          <ArrowLeft style={{ width: 15, height: 15 }} /> Kullanıcılar
        </button>
      </div>

      <Card>
        <div style={{ padding: 24, display: "flex", gap: 20, alignItems: "flex-start" }}>
          <div style={{
            width: 72, height: 72, borderRadius: "50%", flexShrink: 0,
            background: `linear-gradient(135deg, ${C.purple} 0%, #8B8FF5 100%)`,
            display: "flex", alignItems: "center", justifyContent: "center",
          }}>
            <span style={{ color: "#fff", fontWeight: 700, fontSize: 24 }}>{initials}</span>
          </div>

          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ display: "flex", alignItems: "center", gap: 10, flexWrap: "wrap" }}>
              <h1 style={{ fontSize: 20, fontWeight: 800, color: C.textDark, margin: 0 }}>
                {user.displayName || "İsimsiz"}
              </h1>
              <UserStatusBadge status={user.status} />
              <BooleanBadge value={user.isPhoneVerified} trueLabel="Doğrulandı" falseLabel="Doğrulanmamış" />
            </div>

            {user.bio && (
              <p style={{ fontSize: 13, color: C.textMuted, marginTop: 6, lineHeight: 1.5 }}>{user.bio}</p>
            )}

            <div style={{ display: "flex", gap: 20, marginTop: 12, flexWrap: "wrap" }}>
              <span style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, color: C.textMuted }}>
                <Phone style={{ width: 13, height: 13 }} /> {user.phoneNumber}
              </span>
              {user.email && (
                <span style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, color: C.textMuted }}>
                  <Mail style={{ width: 13, height: 13 }} /> {user.email}
                </span>
              )}
              <span style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, color: C.textMuted }}>
                <Calendar style={{ width: 13, height: 13 }} /> Kayıt: {formatDate(user.createdAt)}
              </span>
              {user.lastLoginAt && (
                <span style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, color: C.textMuted }}>
                  <Clock style={{ width: 13, height: 13 }} /> Son giriş: {formatDate(user.lastLoginAt)}
                </span>
              )}
            </div>
          </div>

          <div style={{ display: "flex", gap: 8, flexShrink: 0, flexWrap: "wrap" }}>
            {user.status !== UserStatus.Suspended && user.status !== UserStatus.Banned && (
              <button
                onClick={() => setConfirm("suspend")}
                style={{ display: "flex", alignItems: "center", gap: 6, height: 36, padding: "0 14px", borderRadius: 8, border: `1px solid ${C.cardBorder}`, backgroundColor: "#fff", color: "#F59E0B", fontSize: 13, fontWeight: 500, cursor: "pointer" }}
              >
                <ShieldOff style={{ width: 14, height: 14 }} /> Askıya Al
              </button>
            )}
            {user.status === UserStatus.Suspended && (
              <button
                onClick={() => setConfirm("activate")}
                style={{ display: "flex", alignItems: "center", gap: 6, height: 36, padding: "0 14px", borderRadius: 8, border: `1px solid ${C.cardBorder}`, backgroundColor: "#fff", color: "#15803D", fontSize: 13, fontWeight: 500, cursor: "pointer" }}
              >
                <ShieldCheck style={{ width: 14, height: 14 }} /> Aktifleştir
              </button>
            )}
            {user.status !== UserStatus.Banned && (
              <button
                onClick={() => setConfirm("ban")}
                style={{ display: "flex", alignItems: "center", gap: 6, height: 36, padding: "0 14px", borderRadius: 8, border: "1px solid #FEE2E2", backgroundColor: "#FEF2F2", color: "#B91C1C", fontSize: 13, fontWeight: 500, cursor: "pointer" }}
              >
                <ShieldAlert style={{ width: 14, height: 14 }} /> Banla
              </button>
            )}
            {user.status === UserStatus.Banned && (
              <button
                onClick={() => setConfirm("activate")}
                style={{ display: "flex", alignItems: "center", gap: 6, height: 36, padding: "0 14px", borderRadius: 8, border: `1px solid ${C.cardBorder}`, backgroundColor: "#fff", color: "#15803D", fontSize: 13, fontWeight: 500, cursor: "pointer" }}
              >
                <ShieldCheck style={{ width: 14, height: 14 }} /> Banı Kaldır
              </button>
            )}
          </div>
        </div>

        <div style={{
          display: "flex", borderTop: `1px solid ${C.cardBorder}`,
          padding: "16px 24px",
        }}>
          <StatBubble label="Ort. Puan" value={`★ ${user.averageRating.toFixed(1)}`} color="#B45309" />
          <div style={{ width: 1, backgroundColor: C.cardBorder }} />
          <StatBubble label="Yorum Sayısı" value={user.reviewCount} />
          <div style={{ width: 1, backgroundColor: C.cardBorder }} />
          <StatBubble label="Tamamlanan Etkinlik" value={user.completedActivityCount} color="#15803D" />
          <div style={{ width: 1, backgroundColor: C.cardBorder }} />
          <StatBubble label="Oluşturulan Etkinlik" value={user.createdActivityCount} color={C.purple} />
          <div style={{ width: 1, backgroundColor: C.cardBorder }} />
          <StatBubble label="Şikayet Sayısı" value={user.reportCount} color={user.reportCount > 0 ? "#B91C1C" : C.textMuted} />
        </div>
      </Card>

      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 16 }}>

        <Card>
          <SectionTitle>Son Etkinlikler</SectionTitle>
          {user.recentActivities.length === 0 ? (
            <p style={{ fontSize: 13, color: C.textMuted, padding: "0 20px 20px" }}>Henüz etkinlik yok.</p>
          ) : (
            <div>
              {user.recentActivities.map((a, i) => (
                <div
                  key={a.id}
                  style={{
                    padding: "12px 20px",
                    borderTop: i === 0 ? `1px solid ${C.cardBorder}` : undefined,
                    borderBottom: `1px solid ${C.cardBorder}`,
                    display: "flex", justifyContent: "space-between", alignItems: "center",
                  }}
                >
                  <div>
                    <p style={{ fontSize: 14, fontWeight: 500, color: C.textDark }}>{a.title}</p>
                    <p style={{ fontSize: 12, color: C.textMuted, marginTop: 2 }}>
                      {a.categoryName} · {formatDate(a.eventDate)}
                    </p>
                  </div>
                  <span style={{
                    fontSize: 11, fontWeight: 600, padding: "3px 8px", borderRadius: 6,
                    backgroundColor: C.purpleLight, color: C.purple,
                  }}>
                    {ACTIVITY_STATUS_LABEL[Number(a.status) as keyof typeof ACTIVITY_STATUS_LABEL] ?? a.status}
                  </span>
                </div>
              ))}
            </div>
          )}
        </Card>

        <Card>
          <SectionTitle>Şikayetler</SectionTitle>
          {user.recentReports.length === 0 ? (
            <p style={{ fontSize: 13, color: C.textMuted, padding: "0 20px 20px" }}>Şikayet kaydı yok.</p>
          ) : (
            <div>
              {user.recentReports.map((r, i) => (
                <div
                  key={r.id}
                  style={{
                    padding: "12px 20px",
                    borderTop: i === 0 ? `1px solid ${C.cardBorder}` : undefined,
                    borderBottom: `1px solid ${C.cardBorder}`,
                    display: "flex", justifyContent: "space-between", alignItems: "flex-start",
                  }}
                >
                  <div>
                    <p style={{ fontSize: 14, fontWeight: 500, color: C.textDark }}>{r.reason}</p>
                    <p style={{ fontSize: 12, color: C.textMuted, marginTop: 2 }}>{formatDateTime(r.createdAt)}</p>
                  </div>
                  <span style={{
                    fontSize: 11, fontWeight: 600, padding: "3px 8px", borderRadius: 6,
                    backgroundColor: "#FEF9C3", color: "#A16207",
                  }}>
                    {r.status}
                  </span>
                </div>
              ))}
            </div>
          )}
        </Card>
      </div>

      <ConfirmDialog
        open={!!confirm}
        title={
          confirm === "ban" ? "Kullanıcı banlanacak" :
          confirm === "suspend" ? "Kullanıcı askıya alınacak" :
          "Kullanıcı aktifleştirilecek"
        }
        description="Bu işlemi onaylıyor musunuz?"
        confirmLabel={confirm === "ban" ? "Banla" : confirm === "suspend" ? "Askıya Al" : "Aktifleştir"}
        destructive={confirm === "ban" || confirm === "suspend"}
        onConfirm={handleConfirm}
        onCancel={() => setConfirm(null)}
      />
    </div>
  );
}
