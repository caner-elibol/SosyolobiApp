"use client";

import { use, useEffect } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { TrustBadge } from "@/components/app/TrustBadge";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { ActivityCard } from "@/components/app/ActivityCard";
import { usePublicProfile } from "@/hooks/useProfile";
import {
  useFriendStatus,
  useFriendActivities,
  useSendFriendRequest,
  useRemoveFriend,
  useIncomingFriendRequests,
  useSentFriendRequests,
} from "@/hooks/useFriends";
import { getUserFromToken } from "@/lib/user-auth";
import { CalendarOff, Lock, UserCheck, UserPlus, UserX } from "lucide-react";

function FriendActionButton({ userId }: { userId: string }) {
  const { status, request } = useFriendStatus(userId);
  const sendRequest = useSendFriendRequest();
  const removeFriend = useRemoveFriend();
  const { accept } = useIncomingFriendRequests();
  const { cancel } = useSentFriendRequests();

  const btnStyle: React.CSSProperties = {
    display: "inline-flex",
    alignItems: "center",
    gap: 6,
    padding: "9px 16px",
    borderRadius: "var(--radius-sm)",
    fontSize: 13,
    fontWeight: 600,
    cursor: "pointer",
    border: "none",
  };

  async function handle(fn: () => Promise<unknown>, success: string) {
    try {
      await fn();
      toast.success(success);
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "İşlem başarısız.");
    }
  }

  if (status === "friends") {
    return (
      <button
        onClick={() => handle(() => removeFriend.mutateAsync(userId), "Arkadaşlıktan çıkarıldı.")}
        disabled={removeFriend.isPending}
        style={{ ...btnStyle, background: "#F3F4F6", color: "#374151" }}
      >
        <UserCheck size={15} /> Arkadaşsınız
      </button>
    );
  }

  if (status === "pending-sent" && request) {
    return (
      <button
        onClick={() => handle(() => cancel.mutateAsync(request.id), "İstek iptal edildi.")}
        disabled={cancel.isPending}
        style={{ ...btnStyle, background: "#F3F4F6", color: "#374151" }}
      >
        <UserX size={15} /> İsteği İptal Et
      </button>
    );
  }

  if (status === "pending-incoming" && request) {
    return (
      <button
        onClick={() => handle(() => accept.mutateAsync(request.id), "Arkadaşlık isteği kabul edildi.")}
        disabled={accept.isPending}
        style={{ ...btnStyle, background: "var(--color-accent)", color: "#fff" }}
      >
        <UserCheck size={15} /> İsteği Kabul Et
      </button>
    );
  }

  return (
    <button
      onClick={() => handle(() => sendRequest.mutateAsync(userId), "Arkadaşlık isteği gönderildi.")}
      disabled={sendRequest.isPending}
      style={{ ...btnStyle, background: "var(--color-accent)", color: "#fff" }}
    >
      <UserPlus size={15} /> Arkadaş Ekle
    </button>
  );
}

function FriendActivities({ userId, isFriend }: { userId: string; isFriend: boolean }) {
  const { data = [], isLoading, isError } = useFriendActivities(isFriend ? userId : null);

  if (!isFriend) {
    return (
      <EmptyState
        icon={Lock}
        title="Etkinlikler kilitli"
        description="Bu kullanıcının oluşturduğu etkinlikleri görmek için arkadaş olmanız gerekiyor."
      />
    );
  }

  if (isLoading) return <LoadingState />;
  if (isError || !data.length) {
    return <EmptyState icon={CalendarOff} title="Etkinlik bulunamadı" description="Bu kullanıcının oluşturduğu aktif bir etkinlik yok." />;
  }

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      {data.map((a) => (
        <ActivityCard key={a.id} activity={a} />
      ))}
    </div>
  );
}

export default function PublicProfilePage({ params }: { params: Promise<{ userId: string }> }) {
  const { userId } = use(params);
  const router = useRouter();
  const me = getUserFromToken();
  const isSelf = me?.sub === userId;

  useEffect(() => {
    if (isSelf) router.replace("/app/profile");
  }, [isSelf, router]);

  const { data: profile, isLoading } = usePublicProfile(userId);
  const { status } = useFriendStatus(userId);

  if (isSelf) return null;
  if (isLoading) return <AppShell><LoadingState /></AppShell>;
  if (!profile) return <AppShell><div style={{ padding: 24, color: "var(--color-destructive)" }}>Profil bulunamadı.</div></AppShell>;

  return (
    <AppShell>
      <div style={{ maxWidth: 640, margin: "0 auto", padding: "24px 16px 40px" }}>
        <div style={{
          background: "var(--color-surface)",
          borderRadius: "var(--radius-xl)",
          padding: 24,
          border: "1px solid var(--color-border)",
          marginBottom: 20,
          display: "flex",
          alignItems: "flex-start",
          gap: 16,
          flexWrap: "wrap",
        }}>
          <UserAvatar displayName={profile.displayName} avatarUrl={profile.avatarUrl} size={72} />
          <div style={{ flex: 1, minWidth: 180 }}>
            <h1 style={{ fontSize: 20, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 4px" }}>
              {profile.displayName}
            </h1>
            {profile.bio && <p style={{ fontSize: 14, color: "var(--color-muted-foreground)", margin: "0 0 8px" }}>{profile.bio}</p>}
            <TrustBadge rating={profile.averageRating} />
            <p style={{ fontSize: 12, color: "var(--color-muted-foreground)", margin: "6px 0 0" }}>
              {profile.completedActivityCount} tamamlanan etkinlik · {profile.reviewCount} yorum
            </p>
          </div>
          <FriendActionButton userId={userId} />
        </div>

        <h2 style={{ fontSize: 16, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 12px" }}>
          Oluşturduğu Etkinlikler
        </h2>
        <FriendActivities userId={userId} isFriend={status === "friends"} />
      </div>
    </AppShell>
  );
}
