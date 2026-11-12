"use client";

import { Bell, Search } from "lucide-react";
import { getAdminFromToken } from "@/lib/auth";

export function Topbar({ title }: { title?: string }) {
  const admin = getAdminFromToken();

  return (
    <header style={{
      height: 64, backgroundColor: "#fff",
      borderBottom: "1px solid #F0F1F5",
      display: "flex", alignItems: "center",
      padding: "0 24px", gap: 16,
      position: "sticky", top: 0, zIndex: 10,
    }}>
      {title && (
        <h1 style={{ fontSize: 20, fontWeight: 700, color: "#1B1D29", letterSpacing: "-0.01em", marginRight: "auto" }}>
          {title}
        </h1>
      )}

      <div style={{ position: "relative", marginLeft: title ? 0 : "auto" }}>
        <Search style={{ position: "absolute", left: 11, top: "50%", transform: "translateY(-50%)", width: 15, height: 15, color: "#6B7280" }} />
        <input
          placeholder="Ara…"
          style={{
            height: 38, paddingLeft: 34, paddingRight: 14,
            borderRadius: 10, border: "1px solid #F0F1F5",
            fontSize: 13, width: 220, outline: "none",
            backgroundColor: "#F8F9FF", color: "#1B1D29",
          }}
        />
      </div>

      <div style={{ position: "relative" }}>
        <button style={{
          width: 38, height: 38, borderRadius: 10,
          border: "1px solid #F0F1F5", backgroundColor: "#F8F9FF",
          display: "flex", alignItems: "center", justifyContent: "center",
          cursor: "pointer", color: "#6B7280",
        }}>
          <Bell size={17} />
        </button>
        <div style={{
          position: "absolute", top: 8, right: 8,
          width: 8, height: 8, borderRadius: "50%",
          backgroundColor: "#FF6B6B", border: "2px solid #fff",
        }} />
      </div>

      <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
        <div style={{
          width: 36, height: 36, borderRadius: "50%",
          background: "linear-gradient(135deg, #5B5FE9 0%, #7B61FF 100%)",
          display: "flex", alignItems: "center", justifyContent: "center",
          flexShrink: 0,
        }}>
          <span style={{ color: "#fff", fontSize: 13, fontWeight: 700 }}>
            {(admin?.displayName || "A")[0].toUpperCase()}
          </span>
        </div>
        <div>
          <p style={{ fontSize: 13, fontWeight: 600, color: "#1B1D29", lineHeight: 1 }}>
            {admin?.displayName || "Admin"}
          </p>
          <p style={{ fontSize: 11, color: "#6B7280", marginTop: 2 }}>{admin?.role || "Admin"}</p>
        </div>
      </div>
    </header>
  );
}
