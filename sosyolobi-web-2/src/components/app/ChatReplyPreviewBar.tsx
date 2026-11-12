"use client";

import { X } from "lucide-react";

interface ChatReplyPreviewBarProps {
  senderDisplayName: string;
  content: string;
  onCancel: () => void;
}

export function ChatReplyPreviewBar({ senderDisplayName, content, onCancel }: ChatReplyPreviewBarProps) {
  return (
    <div style={{
      display: "flex",
      alignItems: "flex-start",
      gap: 8,
      padding: "8px 16px",
      background: "#F3F4F6",
      borderTop: "1px solid var(--color-border)",
    }}>
      <div style={{ flex: 1, minWidth: 0, borderLeft: "3px solid var(--color-accent)", paddingLeft: 8 }}>
        <div style={{ fontSize: 12, fontWeight: 600, color: "var(--color-accent)" }}>{senderDisplayName}</div>
        <div style={{
          fontSize: 12,
          color: "var(--color-muted-foreground)",
          overflow: "hidden",
          textOverflow: "ellipsis",
          whiteSpace: "nowrap",
        }}>
          {content}
        </div>
      </div>
      <button
        onClick={onCancel}
        aria-label="Yanıtlamayı iptal et"
        style={{ background: "none", border: "none", cursor: "pointer", color: "var(--color-muted-foreground)", padding: 2, display: "flex" }}
      >
        <X size={16} />
      </button>
    </div>
  );
}
