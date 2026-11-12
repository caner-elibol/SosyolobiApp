import { resolveImageUrl } from "@/lib/image-url";

interface UserAvatarProps {
  displayName: string;
  avatarUrl?: string;
  size?: number;
}

export function UserAvatar({ displayName, avatarUrl, size = 40 }: UserAvatarProps) {
  const initials = displayName
    .split(" ")
    .map((n) => n[0])
    .slice(0, 2)
    .join("")
    .toUpperCase();

  if (avatarUrl) {
    return (
      <img
        src={resolveImageUrl(avatarUrl)}
        alt={displayName}
        style={{
          width: size,
          height: size,
          borderRadius: "50%",
          objectFit: "cover",
          flexShrink: 0,
        }}
      />
    );
  }

  return (
    <div style={{
      width: size,
      height: size,
      borderRadius: "50%",
      background: "var(--color-navy)",
      color: "#fff",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      fontSize: size * 0.35,
      fontWeight: 600,
      flexShrink: 0,
    }}>
      {initials}
    </div>
  );
}
