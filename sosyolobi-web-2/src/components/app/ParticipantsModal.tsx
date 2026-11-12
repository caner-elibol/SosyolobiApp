"use client";

import { UserAvatar } from "@/components/app/UserAvatar";
import { ParticipantActionsMenu } from "@/components/app/ParticipantActionsMenu";
import type { PublicProfile } from "@/types/user";

interface ParticipantsModalProps {
  participants: PublicProfile[];
  currentUserId?: string;
  onClose: () => void;
}

export function ParticipantsModal({ participants, currentUserId, onClose }: ParticipantsModalProps) {
  return (
    <div
      style={{
        position: "fixed",
        inset: 0,
        background: "rgba(0,0,0,0.4)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 400,
        padding: 16,
      }}
      onClick={onClose}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        style={{
          background: "var(--color-surface)",
          borderRadius: "var(--radius-lg)",
          padding: 20,
          width: "100%",
          maxWidth: 380,
          maxHeight: "80vh",
          display: "flex",
          flexDirection: "column",
        }}
      >
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 14 }}>
          <h3 style={{ fontSize: 16, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>Katılımcılar</h3>
          <span style={{ fontSize: 12, color: "var(--color-muted-foreground)" }}>{participants.length} kişi</span>
        </div>

        <div style={{
          overflowY: "auto",
          border: "1px solid var(--color-border)",
          borderRadius: "var(--radius-lg)",
        }}>
          {participants.map((p, i) => (
            <div key={p.userId} style={{
              display: "flex",
              alignItems: "center",
              gap: 8,
              padding: "10px 14px",
              borderTop: i === 0 ? "none" : "1px solid var(--color-border)",
            }}>
              <div style={{ display: "flex", alignItems: "center", gap: 8, flex: 1, minWidth: 0 }}>
                <UserAvatar displayName={p.displayName} avatarUrl={p.avatarUrl} size={32} />
                <span style={{ fontSize: 13, color: "var(--color-foreground)", fontWeight: 500 }}>{p.displayName}</span>
              </div>
              {currentUserId && currentUserId !== p.userId && (
                <ParticipantActionsMenu userId={p.userId} displayName={p.displayName} onBeforeNavigate={onClose} />
              )}
            </div>
          ))}
        </div>

        <button
          onClick={onClose}
          style={{
            marginTop: 14,
            padding: "12px",
            background: "none",
            border: "1px solid var(--color-border)",
            borderRadius: "var(--radius-md)",
            fontSize: 14,
            color: "var(--color-muted-foreground)",
            cursor: "pointer",
          }}
        >
          Kapat
        </button>
      </div>
    </div>
  );
}
