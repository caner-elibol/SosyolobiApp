import type { ActivityMapItem } from "@/types/user";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";

interface ActivityMarkerProps {
  activity: ActivityMapItem;
  onClick: (activity: ActivityMapItem) => void;
  selected?: boolean;
}

export function ActivityMarker({ activity, onClick, selected = false }: ActivityMarkerProps) {
  const Icon = getCategoryIcon(activity.categoryName);
  const color = getCategoryColor(activity.categoryName);

  return (
    <button
      onClick={() => onClick(activity)}
      style={{
        background: color,
        border: "3px solid #fff",
        borderRadius: "50%",
        width: selected ? 48 : 38,
        height: selected ? 48 : 38,
        cursor: "pointer",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        boxShadow: selected ? "0 6px 16px rgba(0,0,0,0.32)" : "0 2px 8px rgba(0,0,0,0.25)",
        transition: "transform 0.15s var(--ease-out), width 0.15s ease, height 0.15s ease",
        transform: selected ? "scale(1.05)" : "scale(1)",
        padding: 0,
      }}
    >
      <Icon size={selected ? 23 : 19} color="#fff" strokeWidth={2.25} />
    </button>
  );
}
