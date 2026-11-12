interface LoadingStateProps {
  message?: string;
}

export function LoadingState({ message = "Yükleniyor..." }: LoadingStateProps) {
  return (
    <div style={{
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "48px 24px",
      gap: 12,
    }}>
      <div style={{
        width: 32,
        height: 32,
        border: "3px solid var(--color-border)",
        borderTopColor: "var(--color-accent)",
        borderRadius: "50%",
        animation: "spin 0.8s linear infinite",
      }} />
      <p style={{ fontSize: 14, color: "var(--color-muted-foreground)", margin: 0 }}>{message}</p>
    </div>
  );
}
