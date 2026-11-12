import type { Category } from "@/types/user";
import { getCategoryIcon } from "@/lib/category-icons";
import { Globe, type LucideIcon } from "lucide-react";

interface FilterChipsProps {
  categories: Category[];
  selected: string | null;
  onSelect: (id: string | null) => void;
  counts?: Record<string, number>;
}

export function FilterChips({ categories, selected, onSelect, counts }: FilterChipsProps) {
  const total = counts ? Object.values(counts).reduce((a, b) => a + b, 0) : undefined;

  return (
    <div className="no-scrollbar" style={{
      display: "flex",
      gap: 8,
      overflowX: "auto",
      padding: "12px 16px",
    }}>
      <Chip
        active={selected === null}
        onClick={() => onSelect(null)}
        label="Tümü"
        icon={Globe}
        count={total}
      />
      {categories.map((cat) => (
        <Chip
          key={cat.id}
          active={selected === cat.id}
          onClick={() => onSelect(selected === cat.id ? null : cat.id)}
          label={cat.name}
          icon={getCategoryIcon(cat.name)}
          count={counts?.[cat.id]}
        />
      ))}
    </div>
  );
}

function Chip({ active, onClick, label, icon: Icon, count }: { active: boolean; onClick: () => void; label: string; icon: LucideIcon; count?: number }) {
  return (
    <button
      onClick={onClick}
      style={{
        display: "inline-flex",
        alignItems: "center",
        gap: 6,
        padding: "8px 14px",
        borderRadius: "var(--radius-full)",
        border: `1px solid ${active ? "var(--color-accent-bright)" : "var(--color-border)"}`,
        background: active ? "var(--color-accent-bright)" : "var(--color-surface)",
        color: active ? "#fff" : "var(--color-muted-foreground)",
        fontSize: 13,
        fontWeight: active ? 600 : 500,
        cursor: "pointer",
        whiteSpace: "nowrap",
        flexShrink: 0,
        transition: "all 0.15s var(--ease-out)",
      }}
    >
      <Icon size={14} strokeWidth={2.25} />
      {label}
      {typeof count === "number" && (
        <span style={{
          display: "inline-flex",
          alignItems: "center",
          justifyContent: "center",
          minWidth: 16,
          height: 16,
          padding: "0 4px",
          borderRadius: "var(--radius-full)",
          background: active ? "rgba(255,255,255,0.28)" : "var(--color-border)",
          color: active ? "#fff" : "var(--color-muted-foreground)",
          fontSize: 10,
          fontWeight: 700,
        }}>
          {count}
        </span>
      )}
    </button>
  );
}
