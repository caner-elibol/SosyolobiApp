"use client";

import { useState } from "react";
import { toast } from "sonner";
import Link from "next/link";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import {
  useFriends,
  useIncomingFriendRequests,
  useSentFriendRequests,
  useRemoveFriend,
} from "@/hooks/useFriends";
import { Star, UserMinus, UserPlus, UserX, Users, X } from "lucide-react";

function FriendsList() {
  const { data = [], isLoading } = useFriends();
  const removeFriend = useRemoveFriend();

  if (isLoading) return <LoadingState />;
  if (!data.length) return (
    <EmptyState icon={Users} title="Henüz arkadaşınız yok" description="Bir kullanıcının profilinden arkadaşlık isteği gönderebilirsiniz." />
  );

  async function handleRemove(userId: string) {
    try {
      await removeFriend.mutateAsync(userId);
      toast.success("Arkadaşlıktan çıkarıldı.");
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "İşlem başarısız.");
    }
  }

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {data.map((f) => (
        <div key={f.user.userId} style={{
          background: "var(--color-surface)",
          border: "1px solid var(--color-border)",
          borderRadius: "var(--radius-lg)",
          padding: 14,
          display: "flex",
          alignItems: "center",
          gap: 12,
        }}>
          <Link href={`/app/profile/${f.user.userId}`} style={{ display: "flex", alignItems: "center", gap: 12, flex: 1, minWidth: 0, textDecoration: "none" }}>
            <UserAvatar displayName={f.user.displayName} avatarUrl={f.user.avatarUrl} size={44} />
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 15, fontWeight: 600, color: "var(--color-foreground)" }}>{f.user.displayName}</div>
              {f.user.averageRating > 0 && (
                <div style={{ display: "flex", alignItems: "center", gap: 4, fontSize: 12, color: "var(--color-muted-foreground)" }}>
                  <Star size={12} fill="#F59E0B" color="#F59E0B" strokeWidth={0} /> {f.user.averageRating.toFixed(1)} · {f.user.completedActivityCount} etkinlik
                </div>
              )}
            </div>
          </Link>
          <button
            onClick={() => handleRemove(f.user.userId)}
            disabled={removeFriend.isPending}
            title="Arkadaşlıktan çıkar"
            style={{
              width: 36, height: 36, borderRadius: "50%", border: "1px solid var(--color-border)",
              background: "none", color: "var(--color-muted-foreground)", cursor: "pointer",
              display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0,
            }}
          >
            <UserMinus size={16} />
          </button>
        </div>
      ))}
    </div>
  );
}

function IncomingFriendRequests() {
  const { data = [], isLoading, accept, reject } = useIncomingFriendRequests();
  if (isLoading) return <LoadingState />;
  if (!data.length) return <EmptyState icon={UserPlus} title="Gelen arkadaşlık isteği yok" />;

  async function handleAccept(id: string) {
    try {
      await accept.mutateAsync(id);
      toast.success("Arkadaşlık isteği kabul edildi.");
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "İşlem başarısız.");
    }
  }

  async function handleReject(id: string) {
    try {
      await reject.mutateAsync(id);
      toast.success("İstek reddedildi.");
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "İşlem başarısız.");
    }
  }

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {data.map((req) => (
        <div key={req.id} style={{
          background: "var(--color-surface)",
          border: "1px solid #FFD580",
          borderRadius: "var(--radius-lg)",
          padding: 14,
          display: "flex",
          alignItems: "center",
          gap: 12,
        }}>
          <Link href={`/app/profile/${req.user.userId}`} style={{ display: "flex", alignItems: "center", gap: 12, flex: 1, minWidth: 0, textDecoration: "none" }}>
            <UserAvatar displayName={req.user.displayName} avatarUrl={req.user.avatarUrl} size={44} />
            <div style={{ fontSize: 15, fontWeight: 600, color: "var(--color-foreground)" }}>{req.user.displayName}</div>
          </Link>
          <div style={{ display: "flex", gap: 8, flexShrink: 0 }}>
            <button
              onClick={() => handleReject(req.id)}
              disabled={reject.isPending}
              style={{ padding: "7px 12px", background: "none", border: "1px solid var(--color-border)", borderRadius: "var(--radius-sm)", fontSize: 13, cursor: "pointer", color: "var(--color-muted-foreground)" }}
            >
              Reddet
            </button>
            <button
              onClick={() => handleAccept(req.id)}
              disabled={accept.isPending}
              style={{ padding: "7px 14px", background: "var(--color-accent)", border: "none", borderRadius: "var(--radius-sm)", fontSize: 13, fontWeight: 600, cursor: "pointer", color: "#fff" }}
            >
              Kabul Et
            </button>
          </div>
        </div>
      ))}
    </div>
  );
}

function SentFriendRequests() {
  const { data = [], isLoading, cancel } = useSentFriendRequests();
  if (isLoading) return <LoadingState />;
  if (!data.length) return <EmptyState icon={UserX} title="Gönderilmiş istek yok" />;

  async function handleCancel(id: string) {
    try {
      await cancel.mutateAsync(id);
      toast.success("İstek iptal edildi.");
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "İşlem başarısız.");
    }
  }

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {data.map((req) => (
        <div key={req.id} style={{
          background: "var(--color-surface)",
          border: "1px solid var(--color-border)",
          borderRadius: "var(--radius-lg)",
          padding: 14,
          display: "flex",
          alignItems: "center",
          gap: 12,
        }}>
          <Link href={`/app/profile/${req.user.userId}`} style={{ display: "flex", alignItems: "center", gap: 12, flex: 1, minWidth: 0, textDecoration: "none" }}>
            <UserAvatar displayName={req.user.displayName} avatarUrl={req.user.avatarUrl} size={44} />
            <div style={{ fontSize: 15, fontWeight: 600, color: "var(--color-foreground)" }}>{req.user.displayName}</div>
          </Link>
          <button
            onClick={() => handleCancel(req.id)}
            disabled={cancel.isPending}
            title="İsteği iptal et"
            style={{
              width: 36, height: 36, borderRadius: "50%", border: "1px solid var(--color-border)",
              background: "none", color: "var(--color-muted-foreground)", cursor: "pointer",
              display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0,
            }}
          >
            <X size={16} />
          </button>
        </div>
      ))}
    </div>
  );
}

export default function FriendsPage() {
  const [tab, setTab] = useState<"friends" | "incoming" | "sent">("friends");
  const { data: incomingCount = [] } = useIncomingFriendRequests();

  return (
    <AppShell>
      <div style={{ maxWidth: 680, margin: "0 auto", padding: "20px 16px 40px" }}>
        <h1 style={{ fontSize: 22, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 20px" }}>
          Arkadaşlar
        </h1>

        <div style={{
          display: "flex",
          background: "#F3F4F6",
          borderRadius: "var(--radius-md)",
          padding: 4,
          marginBottom: 20,
        }}>
          {(["friends", "incoming", "sent"] as const).map((t) => (
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
                position: "relative",
                background: tab === t ? "var(--color-surface)" : "none",
                color: tab === t ? "var(--color-foreground)" : "var(--color-muted-foreground)",
                boxShadow: tab === t ? "var(--shadow-sm)" : "none",
                transition: "all 0.15s var(--ease-out)",
              }}
            >
              {t === "friends" ? "Arkadaşlarım" : t === "incoming" ? "Gelen İstekler" : "Gönderdiğim"}
              {t === "incoming" && incomingCount.length > 0 && (
                <span style={{
                  marginLeft: 6,
                  background: "var(--color-destructive)",
                  color: "#fff",
                  borderRadius: "var(--radius-full)",
                  fontSize: 10,
                  fontWeight: 700,
                  padding: "1px 6px",
                }}>
                  {incomingCount.length}
                </span>
              )}
            </button>
          ))}
        </div>

        {tab === "friends" ? <FriendsList /> : tab === "incoming" ? <IncomingFriendRequests /> : <SentFriendRequests />}
      </div>
    </AppShell>
  );
}
