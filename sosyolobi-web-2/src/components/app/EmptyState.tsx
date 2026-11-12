import { Search, type LucideIcon } from "lucide-react";

interface EmptyStateProps {
  icon?: LucideIcon;
  title: string;
  description?: string;
  action?: React.ReactNode;
}

export function EmptyState({ icon: Icon = Search, title, description, action }: EmptyStateProps) {
  return (
    <div style={{
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "48px 24px",
      textAlign: "center",
    }}>
      <div style={{
        width: 64,
        height: 64,
        borderRadius: "var(--radius-full)",
        background: "var(--color-accent-soft-bg)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        marginBottom: 16,
      }}>
        <Icon size={28} color="var(--color-accent-soft-fg)" strokeWidth={1.75} />
      </div>
      <h3 style={{ fontSize: 17, fontWeight: 600, color: "var(--color-foreground)", margin: "0 0 8px" }}>{title}</h3>
      {description && <p style={{ fontSize: 14, color: "var(--color-muted-foreground)", margin: "0 0 20px", maxWidth: 320 }}>{description}</p>}
      {action}
    </div>
  );
}
