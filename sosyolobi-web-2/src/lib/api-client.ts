import type { ApiResponse } from "@/types/admin";

export class ApiError extends Error {
  constructor(
    public status: number,
    message: string
  ) {
    super(message);
  }
}

function getToken(): string | null {

  if (typeof document === "undefined") return null;

  const match = document.cookie.match(/(?:^|;\s*)admin_token=([^;]+)/);

  const token = match
    ? decodeURIComponent(match[1])
    : null;

  return match ? decodeURIComponent(match[1]) : null;
}

export async function apiClient<T>(
  url: string,
  options?: RequestInit
): Promise<T> {
  const token = getToken();

  const isFormData = options?.body instanceof FormData;

  const response = await fetch(
    `${process.env.NEXT_PUBLIC_API_URL}${url}`,
    {
      ...options,
      headers: {
        ...(isFormData ? {} : { "Content-Type": "application/json" }),
        ...(token ? { Authorization: `Bearer ${token}` } : {}),
        ...(options?.headers ?? {}),
      },
    }
  );

  if (response.status === 401) {
    if (typeof window !== "undefined") {
      window.location.href = "/admin/login";
    }
    throw new ApiError(401, "Oturum süresi doldu.");
  }

  if (!response.ok) {
    const text = await response.text().catch(() => "");
    let message = `HTTP ${response.status}`;
    try {
      const json = JSON.parse(text) as { message?: string };
      if (json.message) message = json.message;
    } catch {
    }
    throw new ApiError(response.status, message);
  }

  const json = (await response.json()) as ApiResponse<T>;
  return json.data;
}
