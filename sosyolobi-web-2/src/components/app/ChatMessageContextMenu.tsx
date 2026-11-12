"use client";

import { useEffect, useRef } from "react";
import { Reply } from "lucide-react";

interface ChatMessageContextMenuProps {
  x: number;
  y: number;
  onReply: () => void;
  onClose: () => void;
}

export function ChatMessageContextMenu({ x, y, onReply, onClose }: ChatMessageContextMenuProps) {
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) onClose();
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [onClose]);

  return (
    <div
      ref={ref}
      style={{
        position: "fixed",
        top: y,
        left: x,
        background: "var(--color-surface)",
        borderRadius: "var(--radius-sm)",
        boxShadow: "var(--shadow-lg)",
        zIndex: 300,
        overflow: "hidden",
        minWidth: 130,
        border: "1px solid var(--color-border)",
      }}
    >
      <button
        onClick={onReply}
        style={{
          display: "flex",
          alignItems: "center",
          gap: 8,
          width: "100%",
          textAlign: "left",
          padding: "10px 14px",
          fontSize: 13,
          color: "var(--color-foreground)",
          background: "none",
          border: "none",
          cursor: "pointer",
        }}
      >
        <Reply size={14} /> Cevapla
      </button>
    </div>
  );
}
