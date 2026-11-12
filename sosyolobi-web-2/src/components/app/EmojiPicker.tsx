"use client";

import { useEffect, useRef, useState } from "react";

const EMOJIS = [
  "😀", "😂", "😍", "😎", "🙏", "👍", "👏", "🎉", "🔥", "❤️",
  "😢", "😡", "🤔", "👋", "💪", "⚽", "🏀", "🎾", "🏃", "🚴",
  "🍕", "☕", "🌧️", "☀️", "✅", "❌", "💬", "📍", "⏰", "🎵",
];

interface EmojiPickerProps {
  onSelect: (emoji: string) => void;
}

export function EmojiPicker({ onSelect }: EmojiPickerProps) {
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!open) return;
    function handleClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [open]);

  return (
    <div ref={ref} style={{ position: "relative" }}>
      <button
        type="button"
        onClick={() => setOpen((o) => !o)}
        aria-label="Emoji ekle"
        style={{
          width: 40,
          height: 40,
          borderRadius: "50%",
          border: "1px solid #EEF2F7",
          background: "#fff",
          fontSize: 18,
          cursor: "pointer",
          flexShrink: 0,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        🙂
      </button>
      {open && (
        <div style={{
          position: "absolute",
          bottom: 48,
          left: 0,
          background: "#fff",
          border: "1px solid #EEF2F7",
          borderRadius: 16,
          padding: 10,
          display: "grid",
          gridTemplateColumns: "repeat(6, 1fr)",
          gap: 4,
          boxShadow: "0 8px 24px rgba(0,0,0,0.12)",
          zIndex: 50,
          width: 240,
        }}>
          {EMOJIS.map((emoji) => (
            <button
              key={emoji}
              type="button"
              onClick={() => {
                onSelect(emoji);
                setOpen(false);
              }}
              style={{
                fontSize: 20,
                background: "none",
                border: "none",
                cursor: "pointer",
                padding: 4,
                borderRadius: 8,
              }}
            >
              {emoji}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
