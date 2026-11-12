import type { AdminTokenPayload } from "@/types/admin";

const TOKEN_KEY = "admin_token";
const COOKIE_MAX_AGE = 60 * 60 * 8;

export function setToken(token: string): void {
  document.cookie = `${TOKEN_KEY}=${encodeURIComponent(token)}; path=/; max-age=${COOKIE_MAX_AGE}; SameSite=Strict`;
}

export function getToken(): string | null {
  if (typeof document === "undefined") return null;
  const match = document.cookie.match(/(?:^|;\s*)admin_token=([^;]+)/);
  return match ? decodeURIComponent(match[1]) : null;
}

export function clearToken(): void {
  document.cookie = `${TOKEN_KEY}=; path=/; max-age=0`;
}

export function parseToken(token: string): AdminTokenPayload | null {
  try {
    const payload = token.split(".")[1];
    return JSON.parse(atob(payload)) as AdminTokenPayload;
  } catch {
    return null;
  }
}

export function isAdminRole(role: string): boolean {
  return role === "Admin" || role === "SuperAdmin";
}

export function getAdminFromToken(): AdminTokenPayload | null {
  const token = getToken();
  if (!token) return null;
  const payload = parseToken(token);
  if (!payload) return null;
  if (payload.exp * 1000 < Date.now()) return null;
  if (!isAdminRole(payload.role)) return null;
  return payload;
}
