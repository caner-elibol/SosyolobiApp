"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useNotifications } from "@/hooks/useNotifications";
import { Calendar, Inbox, MapPin, Plus, User, type LucideIcon } from "lucide-react";

const TABS: { href: string; icon: LucideIcon; label: string; accent?: boolean }[] = [
  { href: "/app/map", icon: MapPin, label: "Keşfet" },
  { href: "/app/activities", icon: Calendar, label: "Etkinlikler" },
  { href: "/app/activities/create", icon: Plus, label: "Oluştur", accent: true },
  { href: "/app/requests", icon: Inbox, label: "İstekler" },
  { href: "/app/profile", icon: User, label: "Profil" },
];

export function AppBottomNav() {
  const pathname = usePathname();
  const { unreadCount } = useNotifications();

  return (
    <nav style={{
      position: "fixed",
      bottom: 0,
      left: 0,
      right: 0,
      height: 64,
      background: "var(--color-surface)",
      borderTop: "1px solid var(--color-border)",
      display: "flex",
      alignItems: "center",
      justifyContent: "space-around",
      zIndex: 200,
      paddingBottom: "env(safe-area-inset-bottom)",
    }} className="show-mobile">
      {TABS.map((tab) => {
        const active = pathname.startsWith(tab.href) && !(tab.href === "/app/activities" && pathname.startsWith("/app/activities/create"));
        const Icon = tab.icon;
        return (
          <Link
            key={tab.href}
            href={tab.href}
            style={{
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              gap: 2,
              textDecoration: "none",
              flex: 1,
              position: "relative",
              minHeight: 44,
              justifyContent: "center",
            }}
          >
            {tab.accent ? (
              <div style={{
                width: 48,
                height: 48,
                background: "var(--color-accent-bright)",
                borderRadius: "50%",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                marginTop: -20,
                boxShadow: "0 4px 12px rgba(194,84,12,0.35)",
              }}>
                <Icon size={22} color="var(--color-navy)" strokeWidth={2.5} />
              </div>
            ) : (
              <span style={{ position: "relative", display: "flex" }}>
                <Icon size={22} color={active ? "var(--color-accent)" : "var(--color-muted-foreground)"} strokeWidth={active ? 2.25 : 2} />
                {tab.href === "/app/requests" && unreadCount > 0 && (
                  <span style={{
                    position: "absolute",
                    top: -4,
                    right: -6,
                    background: "var(--color-destructive)",
                    color: "#fff",
                    borderRadius: "50%",
                    width: 14,
                    height: 14,
                    fontSize: 9,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    fontWeight: 700,
                  }}>!</span>
                )}
              </span>
            )}
            {!tab.accent && (
              <span style={{ fontSize: 10, color: active ? "var(--color-accent)" : "var(--color-muted-foreground)", fontWeight: active ? 600 : 500 }}>
                {tab.label}
              </span>
            )}
          </Link>
        );
      })}
    </nav>
  );
}
