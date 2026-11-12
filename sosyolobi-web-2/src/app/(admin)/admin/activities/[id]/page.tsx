"use client";

import { useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { toast } from "sonner";
import {
  ArrowLeft, MapPin, Calendar, Users, Clock,
  Star, Tag, ChevronRight,
} from "lucide-react";
import { ActivityStatusBadge } from "@/components/admin/StatusBadge";
import { ConfirmDialog } from "@/components/admin/ConfirmDialog";
import { useActivityDetail, useUpdateActivityStatus } from "@/features/admin/activities/useActivities";
import { formatDate, formatDateTime } from "@/lib/format";
import { ActivityStatus } from "@/types/admin";

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
    <div style={{ backgroundColor: C.cardBg, border: `1px solid ${C.cardBorder}`, borderRadius: 16, ...style }}>
      {children}
    </div>
  );
}

function InfoRow({ icon: Icon, label, value }: { icon: React.ElementType; label: string; value: React.ReactNode }) {
  return (
    <div style={{ display: "flex", alignItems: "flex-start", gap: 12, padding: "12px 0", borderBottom: `1px solid ${C.cardBorder}` }}>
      <div style={{ width: 32, height: 32, borderRadius: 8, backgroundColor: C.purpleLight, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
        <Icon style={{ width: 15, height: 15, color: C.purple }} />
      </div>
      <div>
        <p style={{ fontSize: 11, color: C.textMuted, marginBottom: 2 }}>{label}</p>
        <p style={{ fontSize: 14, color: C.textDark, fontWeight: 500 }}>{value}</p>
      </div>
    </div>
  );
}

const SKILL_LABELS: Record<string, string> = {
  "0": "Herhangi", "1": "Başlangıç", "2": "Orta", "3": "İleri",
};
const GENDER_LABELS: Record<string, string> = {
  "0": "Herhangi", "1": "Sadece Erkek", "2": "Sadece Kadın",
};

export default function ActivityDetailPage() {
  const { id } = useParams<{ id: string }>();
  const router = useRouter();
  const { data: activity, isLoading } = useActivityDetail(id);
  const updateStatus = useUpdateActivityStatus();
  const [confirm, setConfirm] = useState<"cancel" | "complete" | null>(null);

  async function handleConfirm() {
    if (!confirm || !activity) return;
    try {
      await updateStatus.mutateAsync({
        id: activity.id,
        status: confirm === "cancel" ? ActivityStatus.Cancelled : ActivityStatus.Completed,
      });
      toast.success("Etkinlik durumu güncellendi.");
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

  if (!activity) {
    return <div style={{ textAlign: "center", paddingTop: 80 }}><p style={{ color: C.textMuted }}>Etkinlik bulunamadı.</p></div>;
  }

  const fillPct = Math.round((activity.currentPeopleCount / activity.neededPeopleCount) * 100);
  const isEditable = activity.status === ActivityStatus.Open || activity.status === ActivityStatus.Full;

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>

      <button
        onClick={() => router.push("/admin/activities")}
        style={{ display: "flex", alignItems: "center", gap: 6, color: C.textMuted, fontSize: 13, background: "none", border: "none", cursor: "pointer", padding: 0, alignSelf: "flex-start" }}
      >
        <ArrowLeft style={{ width: 15, height: 15 }} /> Etkinlikler
      </button>

      <Card style={{ padding: 24 }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", gap: 16 }}>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ display: "flex", alignItems: "center", gap: 10, flexWrap: "wrap", marginBottom: 8 }}>
              <span style={{ fontSize: 12, fontWeight: 600, backgroundColor: C.purpleLight, color: C.purple, padding: "3px 10px", borderRadius: 6 }}>
                {activity.categoryName}
              </span>
              <ActivityStatusBadge status={activity.status} />
            </div>
            <h1 style={{ fontSize: 22, fontWeight: 800, color: C.textDark, margin: 0, lineHeight: 1.3 }}>
              {activity.title}
            </h1>
            {activity.description && (
              <p style={{ fontSize: 13, color: C.textMuted, marginTop: 8, lineHeight: 1.6 }}>
                {activity.description}
              </p>
            )}
          </div>

          {isEditable && (
            <div style={{ display: "flex", gap: 8, flexShrink: 0 }}>
              <button
                onClick={() => setConfirm("complete")}
                style={{ height: 36, padding: "0 14px", borderRadius: 8, border: `1px solid ${C.cardBorder}`, backgroundColor: "#fff", color: "#15803D", fontSize: 13, fontWeight: 500, cursor: "pointer" }}
              >
                Tamamlandı
              </button>
              <button
                onClick={() => setConfirm("cancel")}
                style={{ height: 36, padding: "0 14px", borderRadius: 8, border: "1px solid #FEE2E2", backgroundColor: "#FEF2F2", color: "#B91C1C", fontSize: 13, fontWeight: 500, cursor: "pointer" }}
              >
                İptal Et
              </button>
            </div>
          )}
        </div>

        <div style={{ marginTop: 20 }}>
          <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 6 }}>
            <span style={{ fontSize: 12, color: C.textMuted }}>Katılım doluluk oranı</span>
            <span style={{ fontSize: 12, fontWeight: 600, color: C.textDark }}>
              {activity.currentPeopleCount}/{activity.neededPeopleCount} kişi ({fillPct}%)
            </span>
          </div>
          <div style={{ height: 6, backgroundColor: "#F0F1F5", borderRadius: 99 }}>
            <div style={{ height: "100%", width: `${Math.min(fillPct, 100)}%`, backgroundColor: fillPct >= 100 ? "#15803D" : C.purple, borderRadius: 99, transition: "width 0.3s" }} />
          </div>
        </div>
      </Card>

      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 16 }}>

        <Card style={{ padding: "4px 20px 8px" }}>
          <p style={{ fontSize: 15, fontWeight: 700, color: C.textDark, padding: "16px 0 8px" }}>Etkinlik Detayları</p>
          <InfoRow icon={Calendar} label="Tarih" value={formatDateTime(activity.eventDate)} />
          <InfoRow icon={MapPin} label="Konum" value={activity.addressText} />
          <InfoRow icon={Users} label="Katılımcı" value={`${activity.currentPeopleCount} / ${activity.neededPeopleCount} kişi`} />
          <InfoRow icon={Tag} label="Seviye" value={SKILL_LABELS[activity.skillLevel] ?? activity.skillLevel} />
          <InfoRow icon={Tag} label="Cinsiyet Tercihi" value={GENDER_LABELS[activity.genderPreference] ?? activity.genderPreference} />
          {activity.pricePerPerson != null && (
            <InfoRow icon={Tag} label="Kişi Başı Ücret" value={activity.pricePerPerson === 0 ? "Ücretsiz" : `${activity.pricePerPerson} ₺`} />
          )}
          <InfoRow icon={Clock} label="Oluşturulma" value={formatDateTime(activity.createdAt)} />
        </Card>

        <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
          <Card style={{ padding: 20 }}>
            <p style={{ fontSize: 15, fontWeight: 700, color: C.textDark, marginBottom: 14 }}>Oluşturan</p>
            <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
              <div style={{
                width: 48, height: 48, borderRadius: "50%", flexShrink: 0,
                background: `linear-gradient(135deg, ${C.purple} 0%, #8B8FF5 100%)`,
                display: "flex", alignItems: "center", justifyContent: "center",
              }}>
                <span style={{ color: "#fff", fontWeight: 700 }}>
                  {activity.createdByDisplayName.slice(0, 2).toUpperCase()}
                </span>
              </div>
              <div>
                <p style={{ fontSize: 15, fontWeight: 600, color: C.textDark }}>{activity.createdByDisplayName}</p>
                <button
                  onClick={() => router.push(`/admin/users/${activity.createdByUserId}`)}
                  style={{ display: "flex", alignItems: "center", gap: 4, fontSize: 12, color: C.purple, background: "none", border: "none", cursor: "pointer", padding: 0, marginTop: 3 }}
                >
                  Profili gör <ChevronRight style={{ width: 12, height: 12 }} />
                </button>
              </div>
            </div>
          </Card>

          <Card>
            <p style={{ fontSize: 15, fontWeight: 700, color: C.textDark, padding: "16px 20px 12px" }}>
              Katılımcılar ({activity.participants.length})
            </p>
            {activity.participants.length === 0 ? (
              <p style={{ fontSize: 13, color: C.textMuted, padding: "0 20px 16px" }}>Henüz katılımcı yok.</p>
            ) : (
              <div style={{ maxHeight: 240, overflowY: "auto" }}>
                {activity.participants.map((p, i) => (
                  <div
                    key={p.userId}
                    style={{
                      display: "flex", justifyContent: "space-between", alignItems: "center",
                      padding: "10px 20px",
                      borderTop: `1px solid ${C.cardBorder}`,
                    }}
                  >
                    <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
                      <div style={{ width: 32, height: 32, borderRadius: "50%", backgroundColor: C.purpleLight, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
                        <span style={{ fontSize: 11, fontWeight: 700, color: C.purple }}>
                          {p.displayName.slice(0, 2).toUpperCase()}
                        </span>
                      </div>
                      <p style={{ fontSize: 13, fontWeight: 500, color: C.textDark }}>{p.displayName}</p>
                    </div>
                    <p style={{ fontSize: 11, color: C.textMuted }}>{formatDate(p.joinedAt)}</p>
                  </div>
                ))}
              </div>
            )}
          </Card>
        </div>
      </div>

      {activity.joinRequests.length > 0 && (
        <Card>
          <p style={{ fontSize: 15, fontWeight: 700, color: C.textDark, padding: "16px 20px 12px" }}>
            Katılım Talepleri ({activity.joinRequests.length})
          </p>
          <table style={{ width: "100%", borderCollapse: "collapse" }}>
            <thead>
              <tr style={{ borderTop: `1px solid ${C.cardBorder}` }}>
                {["Kullanıcı", "Durum", "Tarih"].map((h) => (
                  <th key={h} style={{ textAlign: "left", padding: "10px 20px", fontSize: 11, fontWeight: 600, color: C.textMuted, backgroundColor: "#FAFBFD" }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {activity.joinRequests.map((r) => (
                <tr key={r.id} style={{ borderTop: `1px solid ${C.cardBorder}` }}>
                  <td style={{ padding: "12px 20px", fontSize: 14, fontWeight: 500, color: C.textDark }}>{r.displayName}</td>
                  <td style={{ padding: "12px 20px" }}>
                    <span style={{
                      fontSize: 11, fontWeight: 600, padding: "3px 8px", borderRadius: 6,
                      backgroundColor: C.purpleLight, color: C.purple,
                    }}>
                      {r.status}
                    </span>
                  </td>
                  <td style={{ padding: "12px 20px", fontSize: 12, color: C.textMuted }}>{formatDateTime(r.requestedAt)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </Card>
      )}

      <ConfirmDialog
        open={!!confirm}
        title={confirm === "cancel" ? "Etkinlik iptal edilsin mi?" : "Etkinlik tamamlandı olarak işaretlensin mi?"}
        description="Bu işlemi onaylıyor musunuz?"
        confirmLabel={confirm === "cancel" ? "İptal Et" : "Tamamlandı"}
        destructive={confirm === "cancel"}
        onConfirm={handleConfirm}
        onCancel={() => setConfirm(null)}
      />
    </div>
  );
}
