"use client";

import { Calendar, MapPin, Users, Wallet, type LucideIcon } from "lucide-react";

interface JoinActivityModalProps {
  title: string;
  categoryName: string;
  categoryColor: string;
  CategoryIcon: LucideIcon;
  dateLabel: string;
  addressText: string;
  priceLabel: string;
  spotsLabel: string;
  isPending: boolean;
  onConfirm: () => void;
  onClose: () => void;
}

export function JoinActivityModal({
  title,
  categoryName,
  categoryColor,
  CategoryIcon,
  dateLabel,
  addressText,
  priceLabel,
  spotsLabel,
  isPending,
  onConfirm,
  onClose,
}: JoinActivityModalProps) {
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
          padding: 24,
          width: "100%",
          maxWidth: 380,
        }}
      >
        <h3 style={{ fontSize: 16, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 4px" }}>
          Etkinliğe katılmak istiyor musunuz?
        </h3>
        <p style={{ fontSize: 13, color: "var(--color-muted-foreground)", margin: "0 0 16px" }}>
          Onayladığınızda etkinlik sahibine bir katılım isteği gönderilir.
        </p>

        <div style={{
          background: "#F9FAFB",
          borderRadius: "var(--radius-md)",
          padding: 14,
          marginBottom: 20,
        }}>
          <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 10 }}>
            <span style={{
              display: "inline-flex",
              alignItems: "center",
              justifyContent: "center",
              width: 30,
              height: 30,
              borderRadius: "50%",
              background: `color-mix(in srgb, ${categoryColor} 16%, white)`,
              flexShrink: 0,
            }}>
              <CategoryIcon size={16} color={categoryColor} strokeWidth={1.75} />
            </span>
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 14, fontWeight: 700, color: "var(--color-foreground)", overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
                {title}
              </div>
              <div style={{ fontSize: 11, color: categoryColor, fontWeight: 600 }}>{categoryName}</div>
            </div>
          </div>

          <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
            <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 12, color: "#374151" }}>
              <Calendar size={13} /> {dateLabel}
            </div>
            <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 12, color: "#374151" }}>
              <MapPin size={13} /> {addressText}
            </div>
            <div style={{ display: "flex", alignItems: "center", gap: 12, fontSize: 12, color: "#374151" }}>
              <span style={{ display: "flex", alignItems: "center", gap: 6 }}>
                <Wallet size={13} /> {priceLabel}
              </span>
              <span style={{ display: "flex", alignItems: "center", gap: 6 }}>
                <Users size={13} /> {spotsLabel}
              </span>
            </div>
          </div>
        </div>

        <div style={{ display: "flex", gap: 8 }}>
          <button
            onClick={onClose}
            style={{
              flex: 1,
              padding: "12px",
              background: "none",
              border: "1px solid var(--color-border)",
              borderRadius: "var(--radius-md)",
              fontSize: 14,
              color: "var(--color-muted-foreground)",
              cursor: "pointer",
            }}
          >
            Vazgeç
          </button>
          <button
            onClick={onConfirm}
            disabled={isPending}
            style={{
              flex: 1,
              padding: "12px",
              background: "var(--color-accent)",
              color: "#fff",
              border: "none",
              borderRadius: "var(--radius-md)",
              fontSize: 14,
              fontWeight: 600,
              cursor: isPending ? "default" : "pointer",
              opacity: isPending ? 0.7 : 1,
            }}
          >
            {isPending ? "Gönderiliyor..." : "Onaylıyorum"}
          </button>
        </div>
      </div>
    </div>
  );
}
