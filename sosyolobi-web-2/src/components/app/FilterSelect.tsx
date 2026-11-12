export function FilterSelect({ label, value, onChange, options }: {
  label: string;
  value: string;
  onChange: (value: string) => void;
  options: { label: string; value: string }[];
}) {
  return (
    <label style={{
      display: "inline-flex",
      alignItems: "center",
      gap: 6,
      padding: "6px 10px 6px 12px",
      borderRadius: "var(--radius-full)",
      border: "1px solid var(--color-border)",
      background: "var(--color-surface)",
      fontSize: 12,
      fontWeight: 600,
      color: "var(--color-muted-foreground)",
      flexShrink: 0,
      whiteSpace: "nowrap",
    }}>
      {label}
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        style={{
          border: "none",
          background: "transparent",
          fontSize: 12,
          fontWeight: 700,
          color: "var(--color-foreground)",
          outline: "none",
          cursor: "pointer",
        }}
      >
        {options.map((o) => (
          <option key={o.value} value={o.value}>{o.label}</option>
        ))}
      </select>
    </label>
  );
}

export function FilterToggle({ label, active, onClick }: { label: string; active: boolean; onClick: () => void }) {
  return (
    <button
      type="button"
      onClick={onClick}
      style={{
        display: "inline-flex",
        alignItems: "center",
        gap: 6,
        padding: "6px 12px",
        borderRadius: "var(--radius-full)",
        border: `1px solid ${active ? "var(--color-accent-bright)" : "var(--color-border)"}`,
        background: active ? "var(--color-accent-bright)" : "var(--color-surface)",
        color: active ? "#fff" : "var(--color-muted-foreground)",
        fontSize: 12,
        fontWeight: active ? 700 : 600,
        cursor: "pointer",
        whiteSpace: "nowrap",
        flexShrink: 0,
        transition: "all 0.15s var(--ease-out)",
      }}
    >
      {label}
    </button>
  );
}
