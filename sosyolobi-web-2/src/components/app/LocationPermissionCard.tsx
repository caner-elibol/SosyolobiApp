import { MapPin } from "lucide-react";

interface LocationPermissionCardProps {
  onAllow: () => void;
  onDismiss?: () => void;
}

export function LocationPermissionCard({ onAllow, onDismiss }: LocationPermissionCardProps) {
  return (
    <div style={{
      background: "var(--color-surface)",
      border: "1px solid var(--color-border)",
      borderRadius: "var(--radius-lg)",
      padding: "20px 24px",
      display: "flex",
      alignItems: "flex-start",
      gap: 16,
    }}>
      <div style={{
        width: 48,
        height: 48,
        borderRadius: "var(--radius-full)",
        background: "var(--color-accent-soft-bg)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        flexShrink: 0,
      }}>
        <MapPin size={24} color="var(--color-accent-soft-fg)" />
      </div>
      <div style={{ flex: 1 }}>
        <h4 style={{ fontSize: 15, fontWeight: 600, color: "var(--color-foreground)", margin: "0 0 4px" }}>
          Konumuna İzin Ver
        </h4>
        <p style={{ fontSize: 13, color: "var(--color-muted-foreground)", margin: "0 0 12px" }}>
          Yakındaki etkinlikleri görmek için konumuna ihtiyaç var.
        </p>
        <div style={{ display: "flex", gap: 8 }}>
          <button
            onClick={onAllow}
            style={{
              padding: "8px 16px",
              background: "var(--color-accent)",
              color: "#fff",
              border: "none",
              borderRadius: "var(--radius-sm)",
              fontSize: 13,
              fontWeight: 600,
              cursor: "pointer",
            }}
          >
            Konumu Paylaş
          </button>
          {onDismiss && (
            <button
              onClick={onDismiss}
              style={{
                padding: "8px 16px",
                background: "none",
                color: "var(--color-muted-foreground)",
                border: "1px solid var(--color-border)",
                borderRadius: "var(--radius-sm)",
                fontSize: 13,
                cursor: "pointer",
              }}
            >
              Şimdi Değil
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
