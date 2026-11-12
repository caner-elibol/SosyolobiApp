"use client";

import { useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { toast } from "sonner";
import { setUserToken } from "@/lib/user-auth";
import type { ApiResponse, UserAuthResponse } from "@/types/user";
import { ArrowLeft, Smartphone } from "lucide-react";

const schema = z.object({
  code: z.string().length(6, "Kod 6 haneli olmalı"),
});
type FormValues = z.infer<typeof schema>;

export default function VerifyPage() {
  const router = useRouter();
  const phoneRef = useRef<string | null>(null);
  const redirectRef = useRef<string>("/app/map");

  useEffect(() => {
    phoneRef.current = sessionStorage.getItem("otp_phone");
    redirectRef.current = sessionStorage.getItem("otp_redirect") ?? "/app/map";
    if (!phoneRef.current) router.replace("/auth/login");
  }, [router]);

  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
  });

  async function onSubmit(values: FormValues) {
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/verify-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phoneNumber: phoneRef.current, code: values.code }),
      });
      const json = (await res.json()) as ApiResponse<UserAuthResponse>;
      if (!res.ok || !json.success) { toast.error(json.message ?? "Kod hatalı."); return; }
      setUserToken(json.data.accessToken);
      sessionStorage.removeItem("otp_phone");
      sessionStorage.removeItem("otp_redirect");
      window.location.href = redirectRef.current;
    } catch {
      toast.error("Bir hata oluştu. Tekrar deneyin.");
    }
  }

  async function resend() {
    const phone = phoneRef.current;
    if (!phone) return;
    try {
      await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/send-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phoneNumber: phone }),
      });
      toast.success("Kod yeniden gönderildi.");
    } catch {
      toast.error("Yeniden gönderilemedi.");
    }
  }

  return (
    <div style={{
      minHeight: "100dvh",
      background: "linear-gradient(160deg, #fff8ee 0%, #fff3e0 40%, #fafbfd 100%)",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      padding: 24,
      fontFamily: "var(--font-inter), Inter, ui-sans-serif, system-ui, sans-serif",
    }}>
      <div style={{ width: "100%", maxWidth: 400 }}>
        <div style={{ textAlign: "center", marginBottom: 40 }}>
          <div style={{
            width: 56,
            height: 56,
            borderRadius: "var(--radius-md)",
            background: "var(--color-accent-soft-bg)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            margin: "0 auto 12px",
          }}>
            <Smartphone size={26} color="var(--color-accent-soft-fg)" />
          </div>
          <h1 style={{ fontSize: 22, fontWeight: 700, color: "var(--color-navy)", margin: "0 0 4px" }}>Kodu Gir</h1>
          <p style={{ color: "var(--color-muted-foreground)", fontSize: 15, margin: 0 }}>
            Telefon numaranıza gönderilen 6 haneli kodu girin
          </p>
        </div>

        <div style={{
          background: "var(--color-surface)",
          borderRadius: "var(--radius-xl)",
          padding: 32,
          boxShadow: "var(--shadow-lg)",
        }}>
          <form onSubmit={handleSubmit(onSubmit)}>
            <div style={{ marginBottom: 20 }}>
              <input
                {...register("code")}
                type="text"
                inputMode="numeric"
                maxLength={6}
                placeholder="000000"
                style={{
                  width: "100%",
                  padding: "16px",
                  border: `1px solid ${errors.code ? "var(--color-destructive)" : "var(--color-border)"}`,
                  borderRadius: "var(--radius-md)",
                  fontSize: 28,
                  fontWeight: 700,
                  letterSpacing: 12,
                  textAlign: "center",
                  outline: "none",
                  boxSizing: "border-box",
                  fontFamily: "inherit",
                }}
              />
              {errors.code && (
                <p style={{ color: "var(--color-destructive)", fontSize: 12, marginTop: 4 }}>{errors.code.message}</p>
              )}
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              style={{
                width: "100%",
                padding: "13px",
                background: "var(--color-accent)",
                color: "#fff",
                border: "none",
                borderRadius: "var(--radius-md)",
                fontSize: 15,
                fontWeight: 600,
                cursor: isSubmitting ? "not-allowed" : "pointer",
                opacity: isSubmitting ? 0.7 : 1,
              }}
            >
              {isSubmitting ? "Doğrulanıyor..." : "Onayla"}
            </button>
          </form>

          <button
            onClick={resend}
            style={{
              display: "block",
              width: "100%",
              marginTop: 12,
              padding: "10px",
              background: "none",
              border: "none",
              color: "var(--color-muted-foreground)",
              fontSize: 13,
              cursor: "pointer",
            }}
          >
            Kodu tekrar gönder
          </button>

          <button
            onClick={() => router.push("/auth/login")}
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              gap: 6,
              width: "100%",
              marginTop: 4,
              padding: "10px",
              background: "none",
              border: "none",
              color: "var(--color-subtle-foreground)",
              fontSize: 13,
              cursor: "pointer",
            }}
          >
            <ArrowLeft size={13} /> Telefon numarasını değiştir
          </button>
        </div>
      </div>
    </div>
  );
}
