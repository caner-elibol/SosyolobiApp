"use client";

import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import type { HubConnection } from "@microsoft/signalr";
import { useQueryClient } from "@tanstack/react-query";
import { UserAvatar } from "@/components/app/UserAvatar";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { EmojiPicker } from "@/components/app/EmojiPicker";
import { ChatMessageContextMenu } from "@/components/app/ChatMessageContextMenu";
import { ChatReplyPreviewBar } from "@/components/app/ChatReplyPreviewBar";
import { useChatRoom, useChatMessages } from "@/hooks/useChatRoom";
import { useChatUnread } from "@/hooks/useChatUnread";
import { buildChatConnection } from "@/lib/chat-signalr";
import { UserApiError } from "@/lib/user-api-client";
import type { ChatMessage, PagedResponse } from "@/types/user";
import { ChatRoomStatus } from "@/types/user";
import { MessageCircle, Send } from "lucide-react";

function formatTime(iso: string) {
  return new Date(iso).toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
}

interface ChatPanelProps {
  activityId: string;
}

export function ChatPanel({ activityId }: ChatPanelProps) {
  const router = useRouter();
  const qc = useQueryClient();
  const { data: room, isLoading: roomLoading, error: roomError } = useChatRoom(activityId);
  const { data: messagesPage, isLoading: messagesLoading, sendMessage } = useChatMessages(room?.id ?? null);
  const { markChatRead } = useChatUnread();
  const [text, setText] = useState("");
  const [closed, setClosed] = useState(false);
  const [replyTarget, setReplyTarget] = useState<ChatMessage | null>(null);
  const [contextMenu, setContextMenu] = useState<{ message: ChatMessage; x: number; y: number } | null>(null);
  const connectionRef = useRef<HubConnection | null>(null);
  const bottomRef = useRef<HTMLDivElement>(null);

  const messages = [...(messagesPage?.items ?? [])].reverse();

  useEffect(() => {
    if (!room?.id) return;

    let stopped = false;

    const connection = buildChatConnection();
    connectionRef.current = connection;

    connection.on("ReceiveMessage", (message: ChatMessage) => {
      if (message.chatRoomId !== room.id) return;
      qc.setQueryData<PagedResponse<ChatMessage>>(["chat-messages", room.id], (prev) =>
        prev ? { ...prev, items: [message, ...prev.items] } : prev
      );
      markChatRead.mutate(room.id);
    });

    connection.on("RoomClosed", (payload: { id: string }) => {
      if (payload.id !== room.id) return;
      setClosed(true);
      qc.invalidateQueries({ queryKey: ["chat-room", activityId] });
    });

    connection
      .start()
      .then(() => {
        if (stopped) return connection.stop();
        return connection.invoke("JoinRoom", room.id);
      })
      .catch(() => {
        if (!stopped) toast.error("Sohbete bağlanılamadı.");
      });

    return () => {
      stopped = true;
      connection.stop().catch(() => {});
    };
  }, [room?.id, activityId, qc]);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages.length]);

  useEffect(() => {
    if (room?.id) markChatRead.mutate(room.id);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [room?.id]);

  const isClosed = closed || room?.status === ChatRoomStatus.Closed;

  async function handleSend() {
    const content = text.trim();
    if (!content) return;
    try {
      setText("");
      const replyToMessageId = replyTarget?.id;
      setReplyTarget(null);
      await sendMessage.mutateAsync({ content, replyToMessageId });
    } catch (e: unknown) {
      if (e instanceof UserApiError && e.code === "PROFILE_INCOMPLETE") {
        toast.error("Mesaj göndermeden önce profilinizde bir görünen ad belirlemelisiniz.", {
          action: { label: "Profili Düzenle", onClick: () => router.push("/app/profile") },
        });
        return;
      }
      if (e instanceof UserApiError && e.code === "RATE_LIMITED") {
        toast.error("Çok hızlı mesaj gönderiyorsunuz. Lütfen biraz bekleyin.");
        return;
      }
      toast.error(e instanceof Error ? e.message : "Mesaj gönderilemedi.");
    }
  }

  if (roomLoading) return <LoadingState message="Sohbet yükleniyor..." />;
  if (roomError || !room) return <EmptyState icon={MessageCircle} title="Sohbete erişilemiyor" />;

  return (
    <div style={{
      display: "flex",
      flexDirection: "column",
      background: "var(--color-surface)",
      borderRadius: "var(--radius-xl)",
      border: "1px solid var(--color-border)",
      overflow: "hidden",
    }}>
      <div style={{ display: "flex", alignItems: "center", gap: 8, padding: "14px 16px", borderBottom: "1px solid var(--color-border)" }}>
        <MessageCircle size={17} color="var(--color-accent)" />
        <h3 style={{ fontSize: 15, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>Sohbet</h3>
      </div>

      <div style={{ height: 360, overflowY: "auto", padding: "14px 16px", display: "flex", flexDirection: "column", gap: 10 }}>
        {messagesLoading && <LoadingState message="Mesajlar yükleniyor..." />}
        {!messagesLoading && messages.length === 0 && (
          <EmptyState icon={MessageCircle} title="Henüz mesaj yok" description="İlk mesajı sen gönder." />
        )}
        {messages.map((m) => (
          <div
            key={m.id}
            style={{ display: "flex", gap: 8, alignItems: "flex-start" }}
            onContextMenu={(e) => {
              e.preventDefault();
              setContextMenu({ message: m, x: e.clientX, y: e.clientY });
            }}
          >
            <UserAvatar displayName={m.senderDisplayName} avatarUrl={m.senderAvatarUrl} size={32} />
            <div>
              <div style={{ fontSize: 12, color: "var(--color-muted-foreground)", marginBottom: 2 }}>
                {m.senderDisplayName} · {formatTime(m.createdAt)}
              </div>
              <div style={{
                background: "#F3F4F6",
                borderRadius: "var(--radius-md)",
                padding: "8px 12px",
                fontSize: 14,
                color: "var(--color-foreground)",
                maxWidth: 320,
                wordBreak: "break-word",
              }}>
                {m.replyTo && (
                  <div style={{
                    borderLeft: "3px solid var(--color-accent)",
                    paddingLeft: 8,
                    marginBottom: 6,
                    fontSize: 12,
                    color: "var(--color-muted-foreground)",
                  }}>
                    <div style={{ fontWeight: 600, color: "var(--color-accent)" }}>{m.replyTo.senderDisplayName}</div>
                    <div style={{ overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
                      {m.replyTo.content}
                    </div>
                  </div>
                )}
                {m.content}
              </div>
            </div>
          </div>
        ))}
        <div ref={bottomRef} />
      </div>

      {isClosed ? (
        <div style={{
          padding: "14px 20px",
          textAlign: "center",
          color: "var(--color-muted-foreground)",
          fontSize: 14,
          background: "#F3F4F6",
          borderTop: "1px solid var(--color-border)",
        }}>
          Bu etkinlik tamamlandığı için sohbet arşivlendi.
        </div>
      ) : (
        <>
          {replyTarget && (
            <ChatReplyPreviewBar
              senderDisplayName={replyTarget.senderDisplayName}
              content={replyTarget.content}
              onCancel={() => setReplyTarget(null)}
            />
          )}
          <div style={{
            display: "flex",
            alignItems: "center",
            gap: 8,
            padding: "12px 16px",
            borderTop: "1px solid var(--color-border)",
            background: "var(--color-surface)",
          }}>
            <EmojiPicker onSelect={(emoji) => setText((t) => t + emoji)} />
            <input
              value={text}
              onChange={(e) => setText(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === "Enter") handleSend();
              }}
              placeholder="Mesaj yaz..."
              style={{
                flex: 1,
                minWidth: 0,
                padding: "10px 14px",
                border: "1px solid var(--color-border)",
                borderRadius: "var(--radius-full)",
                fontSize: 14,
                outline: "none",
                fontFamily: "inherit",
              }}
            />
            <button
              onClick={handleSend}
              disabled={sendMessage.isPending || !text.trim()}
              style={{
                flexShrink: 0,
                display: "flex",
                alignItems: "center",
                gap: 6,
                padding: "10px 18px",
                background: "var(--color-accent)",
                color: "#fff",
                border: "none",
                borderRadius: "var(--radius-full)",
                fontSize: 14,
                fontWeight: 600,
                cursor: "pointer",
                opacity: sendMessage.isPending || !text.trim() ? 0.6 : 1,
              }}
            >
              <Send size={14} /> Gönder
            </button>
          </div>
        </>
      )}

      {contextMenu && (
        <ChatMessageContextMenu
          x={contextMenu.x}
          y={contextMenu.y}
          onReply={() => {
            setReplyTarget(contextMenu.message);
            setContextMenu(null);
          }}
          onClose={() => setContextMenu(null)}
        />
      )}
    </div>
  );
}
