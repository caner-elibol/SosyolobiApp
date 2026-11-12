"use client";

import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";

interface ClusterMarkerProps {
  count: number;
  categoryName?: string;
  isOverflow?: boolean;
  onClick: () => void;
}

export function ClusterMarker({ count, categoryName, isOverflow, onClick }: ClusterMarkerProps) {
  const size = count >= 50 ? 56 : count >= 10 ? 48 : 40;
  const Icon = categoryName ? getCategoryIcon(categoryName) : null;
  const background = isOverflow ? "var(--color-navy)" : getCategoryColor(categoryName ?? "");

  return (
    <button
      onClick={(e) => {
        e.stopPropagation();
        onClick();
      }}
      title={isOverflow ? `+${count} diğer kategori` : `${categoryName}: ${count}`}
      style={{
        background,
        border: "3px solid #fff",
        borderRadius: "50%",
        width: size,
        height: size,
        cursor: "pointer",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        boxShadow: "0 3px 12px rgba(0,0,0,0.3)",
        padding: 0,
        color: "#fff",
        gap: 1,
      }}
    >
      {!isOverflow && Icon && <Icon size={size >= 48 ? 15 : 12} color="#fff" />}
      <span style={{ fontSize: size >= 48 ? 13 : 11, fontWeight: 700, lineHeight: 1 }}>
        {isOverflow ? `+${count}` : count}
      </span>
    </button>
  );
}
