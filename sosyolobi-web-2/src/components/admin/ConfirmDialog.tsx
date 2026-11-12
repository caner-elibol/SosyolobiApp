"use client";

interface ConfirmDialogProps {
  open: boolean;
  title: string;
  description: string;
  confirmLabel?: string;
  destructive?: boolean;
  onConfirm: () => void;
  onCancel: () => void;
}

export function ConfirmDialog({
  open, title, description, confirmLabel = "Onayla",
  destructive = false, onConfirm, onCancel,
}: ConfirmDialogProps) {
  if (!open) return null;
  return (
    <div style={{
      position: "fixed", inset: 0, zIndex: 50,
      backgroundColor: "rgba(0,0,0,0.4)",
      display: "flex", alignItems: "center", justifyContent: "center",
    }}>
      <div style={{
        backgroundColor: "#fff", borderRadius: 20, padding: 28,
        width: 400, boxShadow: "0 20px 60px rgba(0,0,0,0.15)",
        border: "1px solid #F0F1F5",
      }}>
        <h3 style={{ fontSize: 17, fontWeight: 700, color: "#1B1D29", marginBottom: 8 }}>{title}</h3>
        <p style={{ fontSize: 14, color: "#6B7280", marginBottom: 24 }}>{description}</p>
        <div style={{ display: "flex", gap: 10, justifyContent: "flex-end" }}>
          <button
            onClick={onCancel}
            style={{
              height: 40, padding: "0 20px", borderRadius: 10,
              border: "1px solid #F0F1F5", backgroundColor: "#fff",
              fontSize: 14, fontWeight: 500, color: "#6B7280", cursor: "pointer",
            }}
          >
            Vazgeç
          </button>
          <button
            onClick={onConfirm}
            style={{
              height: 40, padding: "0 20px", borderRadius: 10, border: "none",
              backgroundColor: destructive ? "#B91C1C" : "#5B5FE9",
              color: "#fff", fontSize: 14, fontWeight: 600, cursor: "pointer",
            }}
          >
            {confirmLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
