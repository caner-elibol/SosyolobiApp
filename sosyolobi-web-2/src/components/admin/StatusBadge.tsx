import { type LucideIcon } from "lucide-react";

const STATUS_COLORS: Record<string, { color: string; bg: string }> = {
  "bg-green-100 text-green-700":   { color: "#15803D", bg: "#DCFCE7" },
  "bg-red-100 text-red-700":       { color: "#B91C1C", bg: "#FEE2E2" },
  "bg-yellow-100 text-yellow-700": { color: "#92400E", bg: "#FFF6DE" },
  "bg-blue-100 text-blue-700":     { color: "#1D4ED8", bg: "#E7F1FF" },
  "bg-gray-100 text-gray-600":     { color: "#52525B", bg: "#F4F5F9" },
  "bg-orange-100 text-orange-700": { color: "#9A3412", bg: "#FFEDD5" },
  "bg-purple-100 text-purple-700": { color: "#5B21B6", bg: "#EFEAFE" },
};

import {
  USER_STATUS_LABEL, USER_STATUS_COLOR,
  ACTIVITY_STATUS_LABEL, ACTIVITY_STATUS_COLOR,
  REPORT_STATUS_LABEL, REPORT_STATUS_COLOR,
} from "@/lib/format";
import type { UserStatus, ActivityStatus, ReportStatus } from "@/types/admin";

function Badge({ label, colorKey }: { label: string; colorKey: string }) {
  const t = STATUS_COLORS[colorKey] ?? { color: "#6B7280", bg: "#F4F5F9" };
  return (
    <span style={{
      display: "inline-flex", alignItems: "center",
      padding: "4px 12px", borderRadius: 20,
      fontSize: 12, fontWeight: 600,
      color: t.color, backgroundColor: t.bg,
    }}>
      {label}
    </span>
  );
}

export function UserStatusBadge({ status }: { status: UserStatus }) {
  return <Badge label={USER_STATUS_LABEL[status]} colorKey={USER_STATUS_COLOR[status]} />;
}

export function ActivityStatusBadge({ status }: { status: ActivityStatus }) {
  return <Badge label={ACTIVITY_STATUS_LABEL[status]} colorKey={ACTIVITY_STATUS_COLOR[status]} />;
}

export function ReportStatusBadge({ status }: { status: ReportStatus }) {
  return <Badge label={REPORT_STATUS_LABEL[status]} colorKey={REPORT_STATUS_COLOR[status]} />;
}

export function BooleanBadge({ value, trueLabel = "Evet", falseLabel = "Hayır" }: {
  value: boolean; trueLabel?: string; falseLabel?: string;
}) {
  return (
    <Badge
      label={value ? trueLabel : falseLabel}
      colorKey={value ? "bg-green-100 text-green-700" : "bg-gray-100 text-gray-600"}
    />
  );
}
