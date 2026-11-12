import { type LucideIcon, Inbox } from "lucide-react";

export function EmptyState({
  icon: Icon = Inbox,
  title = "Kayıt bulunamadı.",
  description,
}: {
  icon?: LucideIcon;
  title?: string;
  description?: string;
}) {
  return (
    <div style={{
      padding: "48px 24px",
      display: "flex", flexDirection: "column",
      alignItems: "center", gap: 12, textAlign: "center",
    }}>
      <div style={{
        width: 52, height: 52, borderRadius: "50%",
        backgroundColor: "#EEF0FF",
        display: "flex", alignItems: "center", justifyContent: "center",
      }}>
        <Icon size={22} color="#5B5FE9" />
      </div>
      <p style={{ fontSize: 15, fontWeight: 600, color: "#1B1D29" }}>{title}</p>
      {description && <p style={{ fontSize: 13, color: "#6B7280" }}>{description}</p>}
    </div>
  );
}
