import { BadgeCheck, Star } from "lucide-react";

interface TrustBadgeProps {
  isPhoneVerified?: boolean;
  rating?: number;
  compact?: boolean;
}

export function TrustBadge({ isPhoneVerified, rating, compact = false }: TrustBadgeProps) {
  return (
    <div style={{ display: "flex", alignItems: "center", gap: 6, flexWrap: "wrap" }}>
      {isPhoneVerified && (
        <span style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 3,
          background: "var(--color-success-bg)",
          color: "var(--color-success)",
          fontSize: compact ? 11 : 12,
          fontWeight: 600,
          padding: "2px 8px",
          borderRadius: "var(--radius-full)",
        }}>
          <BadgeCheck size={compact ? 12 : 13} strokeWidth={2.25} /> {!compact && "Doğrulandı"}
        </span>
      )}
      {rating !== undefined && rating > 0 && (
        <span style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 3,
          color: "var(--color-muted-foreground)",
          fontSize: compact ? 12 : 13,
        }}>
          <Star size={compact ? 12 : 13} fill="#F59E0B" color="#F59E0B" strokeWidth={0} /> {rating.toFixed(1)}
        </span>
      )}
    </div>
  );
}
