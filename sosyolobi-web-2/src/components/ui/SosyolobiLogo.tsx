"use client";

interface SosyolobiLogoProps {
  size?: "sm" | "md" | "lg";
  variant?: "navy" | "white";
  animated?: boolean;
  className?: string;
}

const SIZE_MAP: Record<NonNullable<SosyolobiLogoProps["size"]>, number> = {
  sm: 20,
  md: 28,
  lg: 44,
};

export function SosyolobiLogo({
  size = "md",
  variant = "navy",
  animated = true,
  className,
}: SosyolobiLogoProps) {
  const fontSize = SIZE_MAP[size];
  const color = variant === "white" ? "#FFFFFF" : "var(--color-navy)";

  const eyeStyle: React.CSSProperties = {
    display: "inline-block",
    animation: animated ? "blink 5.5s ease-in-out infinite" : "none",
    transformOrigin: "center",
  };

  return (
    <span
      className={className}
      style={{
        fontFamily: "var(--font-nunito), var(--font-inter), sans-serif",
        fontWeight: 800,
        fontSize,
        color,
        letterSpacing: "-0.02em",
        lineHeight: 1,
      }}
    >
      s
      <span style={eyeStyle}>o</span>
      syol
      <span style={{ ...eyeStyle, animationDelay: "0.08s" }}>o</span>
      bi
    </span>
  );
}
