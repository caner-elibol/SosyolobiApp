import { type LucideIcon } from "lucide-react";

interface StatCardProps {
  icon: LucideIcon;
  label: string;
  value: string | number;
  iconBg: string;
  iconColor: string;
  trend?: string;
}

export function StatCard({ icon: Icon, label, value, iconBg, iconColor, trend }: StatCardProps) {
  return (
    <div style={{
      backgroundColor: "#fff", borderRadius: 16, padding: 20,
      border: "1px solid #F0F1F5",
      display: "flex", alignItems: "center", gap: 16,
    }}>
      <div style={{
        width: 56, height: 56, borderRadius: "50%",
        backgroundColor: iconBg, display: "flex",
        alignItems: "center", justifyContent: "center", flexShrink: 0,
      }}>
        <Icon size={24} color={iconColor} fill={iconColor} strokeWidth={1.5} />
      </div>
      <div>
        <p style={{ fontSize: 26, fontWeight: 700, color: "#1B1D29", letterSpacing: "-0.02em", lineHeight: 1 }}>
          {value}
        </p>
        <p style={{ fontSize: 13, color: "#6B7280", marginTop: 4 }}>{label}</p>
        {trend && (
          <p style={{ fontSize: 11, color: "#15803D", marginTop: 2, fontWeight: 500 }}>{trend}</p>
        )}
      </div>
    </div>
  );
}
