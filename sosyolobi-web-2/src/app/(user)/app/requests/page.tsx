"use client";

import { useState } from "react";
import { toast } from "sonner";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { ActivityCard } from "@/components/app/ActivityCard";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useSentRequests, useIncomingRequests, useMyJoinedActivities } from "@/hooks/useJoinRequest";
import { useActivity } from "@/hooks/useCreateActivity";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";
import { ActivityRequestStatus } from "@/types/user";
import Link from "next/link";
import { CalendarCheck, Inbox, Send, Star } from "lucide-react";

function RequestActivitySnippet({ activityId }: { activityId: string }) {
  const { data: activity, isLoading } = useActivity(activityId);
  if (isLoading || !activity) return null;
  const Icon = getCategoryIcon(activity.categoryName);
  const color = getCategoryColor(activity.categoryName);

  return (
    <div style={{
      display: "flex",
      alignItems: "center",
      gap: 8,
      padding: "8px 10px",
      background: "#F9FAFB",
      borderRadius: "var(--radius-sm)",
    }}>
      <span style={{
        width: 28,
        height: 28,
        borderRadius: "var(--radius-sm)",
        background: `color-mix(in srgb, ${color} 16%, white)`,
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        flexShrink: 0,
      }}>
        <Icon size={14} color={color} />
      </span>
      <div style={{ minWidth: 0, flex: 1 }}>
        <div style={{ fontSize: 13, fontWeight: 600, color: "var(--color-foreground)", overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
          {activity.title}
        </div>
        <div style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>
          {activity.categoryName} · {new Date(activity.eventDate).toLocaleDateString("tr-TR", { day: "numeric", month: "short" })}
        </div>
      </div>
    </div>
  );
}

const STATUS_LABELS: Record<number, { label: string; color: string }> = {
  [ActivityRequestStatus.Pending]:   { label: "Bekliyor",  color: "#B45309" },
  [ActivityRequestStatus.Approved]:  { label: "Onaylandı", color: "#15803D" },
  [ActivityRequestStatus.Rejected]:  { label: "Reddedildi", color: "#DC2626" },
  [ActivityRequestStatus.Cancelled]: { label: "İptal",     color: "#6B7280" },
};

function SentRequests() {
  const { data = [], isLoading } = useSentRequests();
  if (isLoading) return <LoadingState />;
  if (!data.length) return <EmptyState icon={Send} title="Henüz istek göndermediniz" />;

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {data.map((req) => {
        const s = STATUS_LABELS[req.status];
        return (
          <Link key={req.id} href={`/app/activities/${req.activityId}`} style={{ textDecoration: "none" }}>
            <div style={{
              background: "var(--color-surface)",
              border: "1px solid var(--color-border)",
              borderRadius: "var(--radius-lg)",
              padding: "12px",
              display: "flex",
              flexDirection: "column",
              gap: 10,
            }}>
              <RequestActivitySnippet activityId={req.activityId} />
              <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "0 2px" }}>
                <div style={{ fontSize: 12, color: "var(--color-muted-foreground)" }}>
                  İstek: {new Date(req.createdAt).toLocaleDateString("tr-TR")}
                </div>
                <span style={{
                  padding: "4px 10px",
                  borderRadius: "var(--radius-full)",
                  fontSize: 12,
                  fontWeight: 600,
                  background: `${s?.color}18`,
                  color: s?.color,
                }}>
                  {s?.label ?? "Bilinmiyor"}
                </span>
              </div>
            </div>
          </Link>
        );
      })}
    </div>
  );
}

function IncomingRequests() {
  const { data = [], isLoading, approve, reject } = useIncomingRequests();

  if (isLoading) return <LoadingState />;
  if (!data.length) return (
    <EmptyState
      icon={Inbox}
      title="Henüz gelen istek yok"
      description="Oluşturduğunuz etkinliklere katılım isteği geldiğinde burada görünecek."
    />
  );

  const pending = data.filter((r) => r.status === ActivityRequestStatus.Pending);
  const others  = data.filter((r) => r.status !== ActivityRequestStatus.Pending);

  async function handleApprove(requestId: string) {
    try {
      await approve.mutateAsync(requestId);
      toast.success("İstek onaylandı.");
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "Onaylanamadı.");
    }
  }

  async function handleReject(requestId: string) {
    try {
      await reject.mutateAsync(requestId);
      toast.success("İstek reddedildi.");
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "Reddedilemedi.");
    }
  }

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {pending.length > 0 && (
        <p style={{ fontSize: 13, fontWeight: 600, color: "var(--color-muted-foreground)", margin: "0 0 4px" }}>
          Bekleyen ({pending.length})
        </p>
      )}
      {[...pending, ...others].map((req) => {
        const s = STATUS_LABELS[req.status];
        const isPending = req.status === ActivityRequestStatus.Pending;
        return (
          <div key={req.id} style={{
            background: "var(--color-surface)",
            border: `1px solid ${isPending ? "#FFD580" : "var(--color-border)"}`,
            borderRadius: "var(--radius-lg)",
            padding: "16px",
          }}>
            <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: isPending ? 12 : 0 }}>
              <UserAvatar displayName={req.user.displayName} avatarUrl={req.user.avatarUrl} size={44} />
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 15, fontWeight: 600, color: "var(--color-foreground)" }}>{req.user.displayName}</div>
                {req.user.averageRating > 0 && (
                  <div style={{ display: "flex", alignItems: "center", gap: 4, fontSize: 12, color: "var(--color-muted-foreground)" }}>
                    <Star size={12} fill="#F59E0B" color="#F59E0B" strokeWidth={0} /> {req.user.averageRating.toFixed(1)} · {req.user.completedActivityCount} etkinlik
                  </div>
                )}
              </div>
              <span style={{
                padding: "4px 10px",
                borderRadius: "var(--radius-full)",
                fontSize: 12,
                fontWeight: 600,
                background: `${s?.color}18`,
                color: s?.color,
                flexShrink: 0,
              }}>
                {s?.label}
              </span>
            </div>

            <div style={{ margin: isPending ? "0 0 12px" : "8px 0 0" }}>
              <RequestActivitySnippet activityId={req.activityId} />
            </div>

            {req.message && (
              <p style={{
                fontSize: 13,
                color: "#374151",
                background: "#F9FAFB",
                borderRadius: "var(--radius-sm)",
                padding: "8px 12px",
                margin: isPending ? "0 0 12px" : "8px 0 0",
              }}>
                "{req.message}"
              </p>
            )}

            <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}>
              <Link
                href={`/app/activities/${req.activityId}`}
                style={{ fontSize: 12, color: "var(--color-muted-foreground)", textDecoration: "none" }}
              >
                Etkinliği Gör →
              </Link>

              {isPending && (
                <div style={{ display: "flex", gap: 8 }}>
                  <button
                    onClick={() => handleReject(req.id)}
                    disabled={reject.isPending}
                    style={{
                      padding: "7px 14px",
                      background: "none",
                      border: "1px solid var(--color-border)",
                      borderRadius: "var(--radius-sm)",
                      fontSize: 13,
                      cursor: "pointer",
                      color: "var(--color-muted-foreground)",
                    }}
                  >
                    Reddet
                  </button>
                  <button
                    onClick={() => handleApprove(req.id)}
                    disabled={approve.isPending}
                    style={{
                      padding: "7px 16px",
                      background: "var(--color-accent)",
                      border: "none",
                      borderRadius: "var(--radius-sm)",
                      fontSize: 13,
                      fontWeight: 600,
                      cursor: "pointer",
                      color: "#fff",
                    }}
                  >
                    Onayla
                  </button>
                </div>
              )}
            </div>
          </div>
        );
      })}
    </div>
  );
}

function JoinedActivities() {
  const { data = [], isLoading } = useMyJoinedActivities();
  if (isLoading) return <LoadingState />;
  if (!data.length) return (
    <EmptyState
      icon={CalendarCheck}
      title="Yaklaşan etkinliğiniz yok"
      description="Katılım isteğiniz onaylanan yaklaşan etkinlikler burada görünecek."
    />
  );

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {data.map((a) => (
        <ActivityCard key={a.id} activity={a} />
      ))}
    </div>
  );
}

export default function RequestsPage() {
  const [tab, setTab] = useState<"sent" | "incoming" | "joined">("incoming");

  return (
    <AppShell>
      <div style={{ maxWidth: 680, margin: "0 auto", padding: "20px 16px 40px" }}>
        <h1 style={{ fontSize: 22, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 20px" }}>
          Katılım İstekleri
        </h1>

        <div style={{
          display: "flex",
          background: "#F3F4F6",
          borderRadius: "var(--radius-md)",
          padding: 4,
          marginBottom: 20,
        }}>
          {(["incoming", "sent", "joined"] as const).map((t) => (
            <button
              key={t}
              onClick={() => setTab(t)}
              style={{
                flex: 1,
                padding: "8px",
                border: "none",
                borderRadius: "calc(var(--radius-md) - 3px)",
                fontSize: 14,
                fontWeight: 600,
                cursor: "pointer",
                background: tab === t ? "var(--color-surface)" : "none",
                color: tab === t ? "var(--color-foreground)" : "var(--color-muted-foreground)",
                boxShadow: tab === t ? "var(--shadow-sm)" : "none",
                transition: "all 0.15s var(--ease-out)",
              }}
            >
              {t === "incoming" ? "Gelen İstekler" : t === "sent" ? "Gönderdiğim" : "Katıldıklarım"}
            </button>
          ))}
        </div>

        {tab === "incoming" ? <IncomingRequests /> : tab === "sent" ? <SentRequests /> : <JoinedActivities />}
      </div>
    </AppShell>
  );
}
