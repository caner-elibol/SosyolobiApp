"use client";

import { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  LayoutGrid, Users, CalendarCheck, Flag, Star, Tag,
  ChevronLeft, ChevronRight, LogOut,
} from "lucide-react";
import { clearToken } from "@/lib/auth";
import { useRouter } from "next/navigation";

const NAV = [
  { href: "/admin/dashboard", icon: LayoutGrid, label: "Dashboard" },
  { href: "/admin/users",     icon: Users,        label: "Kullanıcılar" },
  { href: "/admin/activities",icon: CalendarCheck, label: "Etkinlikler" },
  { href: "/admin/reports",   icon: Flag,         label: "Şikayetler" },
  { href: "/admin/reviews",   icon: Star,         label: "Yorumlar" },
  { href: "/admin/categories",icon: Tag,          label: "Kategoriler" },
];

export function Sidebar() {
  const pathname = usePathname();
  const router = useRouter();
  const [collapsed, setCollapsed] = useState(false);
  const w = collapsed ? 72 : 240;

  function logout() { clearToken(); router.replace("/admin/login"); }

  return (
    <aside
      style={{
        width: w, minHeight: "100vh", backgroundColor: "#fff",
        borderRight: "1px solid #F0F1F5",
        display: "flex", flexDirection: "column",
        transition: "width 0.2s ease",
        flexShrink: 0, position: "sticky", top: 0, height: "100vh",
      }}
    >
      <div style={{
        height: 64, display: "flex", alignItems: "center",
        padding: collapsed ? "0 16px" : "0 20px",
        justifyContent: collapsed ? "center" : "space-between",
        borderBottom: "1px solid #F0F1F5",
      }}>
        {!collapsed && (
          <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
            <div style={{
              width: 36, height: 36, borderRadius: "50%",
              backgroundColor: "#5B5FE9",
              display: "flex", alignItems: "center", justifyContent: "center",
            }}>
              <span style={{ color: "#fff", fontWeight: 700, fontSize: 15 }}>S</span>
            </div>
            <span style={{ fontWeight: 700, fontSize: 16, color: "#1B1D29" }}>Sosyolobi</span>
          </div>
        )}
        {collapsed && (
          <div style={{
            width: 36, height: 36, borderRadius: "50%",
            backgroundColor: "#5B5FE9",
            display: "flex", alignItems: "center", justifyContent: "center",
          }}>
            <span style={{ color: "#fff", fontWeight: 700, fontSize: 15 }}>S</span>
          </div>
        )}
        <button
          onClick={() => setCollapsed(!collapsed)}
          style={{
            width: 28, height: 28, borderRadius: 8, border: "1px solid #F0F1F5",
            backgroundColor: "#fff", cursor: "pointer",
            display: "flex", alignItems: "center", justifyContent: "center",
            color: "#6B7280", flexShrink: 0,
          }}
        >
          {collapsed ? <ChevronRight size={14} /> : <ChevronLeft size={14} />}
        </button>
      </div>

      <nav style={{ flex: 1, padding: "16px 12px", display: "flex", flexDirection: "column", gap: 4 }}>
        {NAV.map(({ href, icon: Icon, label }) => {
          const active = pathname === href || pathname.startsWith(href + "/");
          return (
            <Link
              key={href}
              href={href}
              style={{
                display: "flex", alignItems: "center",
                gap: collapsed ? 0 : 12,
                justifyContent: collapsed ? "center" : "flex-start",
                padding: collapsed ? "10px 0" : "10px 12px",
                borderRadius: 12,
                backgroundColor: active ? "#EEF0FF" : "transparent",
                color: active ? "#5B5FE9" : "#6B7280",
                fontWeight: active ? 600 : 400,
                fontSize: 14,
                textDecoration: "none",
                transition: "background-color 0.15s, color 0.15s",
              }}
              onMouseEnter={(e) => { if (!active) (e.currentTarget as HTMLElement).style.backgroundColor = "#F8F9FF"; }}
              onMouseLeave={(e) => { if (!active) (e.currentTarget as HTMLElement).style.backgroundColor = "transparent"; }}
            >
              <Icon size={19} strokeWidth={active ? 2.5 : 1.8} />
              {!collapsed && label}
            </Link>
          );
        })}
      </nav>

      <div style={{ padding: "12px", borderTop: "1px solid #F0F1F5" }}>
        <button
          onClick={logout}
          style={{
            width: "100%", display: "flex", alignItems: "center",
            gap: collapsed ? 0 : 12,
            justifyContent: collapsed ? "center" : "flex-start",
            padding: collapsed ? "10px 0" : "10px 12px",
            borderRadius: 12, border: "none", backgroundColor: "transparent",
            color: "#6B7280", fontSize: 14, cursor: "pointer",
          }}
          onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = "#FFF0F0")}
          onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = "transparent")}
        >
          <LogOut size={18} />
          {!collapsed && "Çıkış Yap"}
        </button>
      </div>
    </aside>
  );
}
