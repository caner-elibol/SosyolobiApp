import type { ApiResponse } from "@/types/user";

export class UserApiError extends Error {
  constructor(
    public status: number,
    message: string,
    public code?: string
  ) {
    super(message);
  }
}

function getUserToken(): string | null {
  if (typeof document === "undefined") return null;
  const match = document.cookie.match(/(?:^|;\s*)user_token=([^;]+)/);
  return match ? decodeURIComponent(match[1]) : null;
}

export async function userApiClient<T>(
  url: string,
  options?: RequestInit
): Promise<T> {
  const token = getUserToken();
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
      window.location.href = "/auth/login";
    }
    throw new UserApiError(401, "Oturum süresi doldu.");
  }

  if (!response.ok) {
    const text = await response.text().catch(() => "");
    let message = `HTTP ${response.status}`;
    let code: string | undefined;
    try {
      const json = JSON.parse(text) as { message?: string; code?: string };
      if (json.message) message = json.message;
      code = json.code;
    } catch {
    }
    throw new UserApiError(response.status, message, code);
  }

  const json = (await response.json()) as ApiResponse<T>;
  return json.data;
}
