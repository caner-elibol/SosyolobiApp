"use client";

import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { useNotifications } from "@/hooks/useNotifications";
import { useChatUnread } from "@/hooks/useChatUnread";
import {
  AlertTriangle,
  Ban,
  Bell,
  BellRing,
  CheckCircle2,
  CheckCircle,
  MessageSquare,
  Star,
  XCircle,
  type LucideIcon,
} from "lucide-react";

const NOTIF_ICONS: Record<number, LucideIcon> = {
  1: BellRing,
  2: CheckCircle2,
  3: XCircle,
  4: Ban,
  5: CheckCircle,
  6: Star,
  7: AlertTriangle,
};

interface FeedItem {
  key: string;
  icon: LucideIcon;
  title: string;
  message?: string;
  activityTitle?: string;
  isRead: boolean;
  createdAt: string;
  onOpen: () => void;
}

export function NotificationsBell({ className }: { className?: string }) {
  const router = useRouter();
  const { data: notifications = [], isLoading: notifLoading, markRead, markAllRead } = useNotifications();
  const { data: chatUnread = [], isLoading: chatLoading, markChatRead } = useChatUnread();
  const [open, setOpen] = useState(false);
  const rootRef = useRef<HTMLDivElement>(null);

  const isLoading = notifLoading || chatLoading;
  const badgeCount = notifications.filter((n) => !n.isRead).length + chatUnread.length;

  useEffect(() => {
    if (!open) return;
    function handleClickOutside(e: MouseEvent) {
      if (rootRef.current && !rootRef.current.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [open]);

  useEffect(() => {
    if (open && notifications.some((n) => !n.isRead)) {
      markAllRead.mutate();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open]);

  const items: FeedItem[] = [
    ...notifications.map((n): FeedItem => ({
      key: `n-${n.id}`,
      icon: NOTIF_ICONS[n.type] ?? Bell,
      title: n.title,
      message: n.message,
      activityTitle: n.relatedActivityTitle,
      isRead: n.isRead,
      createdAt: n.createdAt,
      onOpen: () => {
        if (!n.isRead) markRead.mutate(n.id);
        if (n.relatedActivityId) router.push(`/app/activities/${n.relatedActivityId}`);
      },
    })),
    ...chatUnread.map((c): FeedItem => ({
      key: `c-${c.chatRoomId}`,
      icon: MessageSquare,
      title: `${c.activityTitle} Chat'i`,
      message: `${c.unreadCount} yeni mesaj`,
      isRead: false,
      createdAt: new Date().toISOString(),
      onOpen: () => {
        markChatRead.mutate(c.chatRoomId);
        router.push(`/app/activities/${c.activityId}?chat=1`);
      },
    })),
  ].sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());

  function handleOpenItem(item: FeedItem) {
    item.onOpen();
    setOpen(false);
  }

  return (
    <div ref={rootRef} className={className} style={{ position: "relative", display: "flex", alignItems: "center" }}>
      <button
        onClick={() => setOpen((o) => !o)}
        aria-label="Bildirimler"
        style={{
          position: "relative",
          background: "none",
          border: "none",
          cursor: "pointer",
          padding: 0,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <Bell size={21} color="var(--color-foreground)" strokeWidth={2} />
        {badgeCount > 0 && (
          <span style={{
            position: "absolute",
            top: -3,
            right: -3,
            background: "var(--color-destructive)",
            color: "#fff",
            borderRadius: "50%",
            width: 15,
            height: 15,
            fontSize: 9,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            fontWeight: 700,
          }}>
            {badgeCount > 9 ? "9+" : badgeCount}
          </span>
        )}
      </button>

      {open && (
        <div style={{
          position: "absolute",
          top: 36,
          right: 0,
          width: 340,
          maxWidth: "calc(100vw - 32px)",
          maxHeight: 420,
          overflowY: "auto",
          background: "var(--color-surface)",
          borderRadius: "var(--radius-md)",
          boxShadow: "var(--shadow-lg)",
          border: "1px solid var(--color-border)",
          zIndex: 300,
        }}>
          <div style={{
            padding: "12px 14px",
            borderBottom: "1px solid var(--color-border)",
            fontSize: 14,
            fontWeight: 700,
            color: "var(--color-foreground)",
            position: "sticky",
            top: 0,
            background: "var(--color-surface)",
          }}>
            Bildirimler
          </div>

          {isLoading && (
            <div style={{ padding: 20, textAlign: "center", fontSize: 13, color: "var(--color-muted-foreground)" }}>
              Yükleniyor...
            </div>
          )}

          {!isLoading && items.length === 0 && (
            <div style={{ padding: "28px 16px", textAlign: "center" }}>
              <Bell size={22} color="var(--color-subtle-foreground)" style={{ marginBottom: 8 }} />
              <p style={{ fontSize: 13, color: "var(--color-muted-foreground)", margin: 0 }}>Henüz bildirim yok</p>
            </div>
          )}

          <div style={{ display: "flex", flexDirection: "column" }}>
            {items.map((item) => {
              const Icon = item.icon;
              return (
                <div
                  key={item.key}
                  onClick={() => handleOpenItem(item)}
                  style={{
                    display: "flex",
                    gap: 10,
                    padding: "10px 14px",
                    cursor: "pointer",
                    borderBottom: "1px solid var(--color-border)",
                    background: item.isRead ? "transparent" : "var(--color-accent-soft-bg)",
                  }}
                >
                  <div style={{
                    width: 30,
                    height: 30,
                    flexShrink: 0,
                    borderRadius: "50%",
                    background: item.isRead ? "#F3F4F6" : "var(--color-surface)",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                  }}>
                    <Icon size={15} color={item.isRead ? "var(--color-muted-foreground)" : "var(--color-accent)"} />
                  </div>
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ fontSize: 13, fontWeight: 600, color: "var(--color-foreground)" }}>{item.title}</div>
                    {item.message && (
                      <div style={{ fontSize: 12, color: "var(--color-muted-foreground)" }}>{item.message}</div>
                    )}
                    {item.activityTitle && (
                      <div style={{ fontSize: 11, color: "var(--color-accent)", fontWeight: 600, marginTop: 2 }}>
                        {item.activityTitle}
                      </div>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
