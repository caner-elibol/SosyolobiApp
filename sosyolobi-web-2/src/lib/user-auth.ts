import type { UserTokenPayload } from "@/types/user";

const TOKEN_KEY = "user_token";
const COOKIE_MAX_AGE = 60 * 60 * 24 * 7;

export function setUserToken(token: string): void {
  document.cookie = `${TOKEN_KEY}=${encodeURIComponent(token)}; path=/; max-age=${COOKIE_MAX_AGE}; SameSite=Strict`;
}

export function getUserToken(): string | null {
  if (typeof document === "undefined") return null;
  const match = document.cookie.match(/(?:^|;\s*)user_token=([^;]+)/);
  return match ? decodeURIComponent(match[1]) : null;
}

export function clearUserToken(): void {
  document.cookie = `${TOKEN_KEY}=; path=/; max-age=0`;
}

export function parseUserToken(token: string): UserTokenPayload | null {
  try {
    const payload = token.split(".")[1];
    return JSON.parse(atob(payload)) as UserTokenPayload;
  } catch {
    return null;
  }
}

export function getUserFromToken(): UserTokenPayload | null {
  const token = getUserToken();
  if (!token) return null;
  const payload = parseUserToken(token);
  if (!payload) return null;
  if (payload.exp * 1000 < Date.now()) return null;
  return payload;
}
