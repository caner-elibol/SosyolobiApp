export function resolveImageUrl<T extends string | null | undefined>(url: T): T {
  if (!url) return url;
  const apiBase = process.env.NEXT_PUBLIC_API_URL;
  if (!apiBase) return url;
  try {
    const parsed = new URL(url, apiBase);
    const base = new URL(apiBase);
    if (parsed.origin === base.origin) return url;
    return `${base.origin}${parsed.pathname}${parsed.search}` as T;
  } catch {
    return url;
  }
}
