"use client";

import { Suspense, useEffect } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { toast } from "sonner";
import { getUserFromToken } from "@/lib/user-auth";
import type { ApiResponse } from "@/types/user";
import { Compass } from "lucide-react";

const schema = z.object({
  phoneNumber: z.string().min(10, "Gecerli bir telefon numarasi girin"),
});
type FormValues = z.infer<typeof schema>;

function LoginForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirect = searchParams.get("redirect") ?? "/app/map";

  useEffect(() => {
    if (getUserFromToken()) router.replace("/app/map");
  }, [router]);

  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
  });

  async function onSubmit(values: FormValues) {
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/send-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phoneNumber: values.phoneNumber }),
      });
      const json = (await res.json()) as ApiResponse<null>;
      if (!res.ok || !json.success) { toast.error(json.message ?? "OTP gonderilemedi."); return; }
      sessionStorage.setItem("otp_phone", values.phoneNumber);
      sessionStorage.setItem("otp_redirect", redirect);
      router.push("/auth/verify");
    } catch {
      toast.error("Bir hata olustu. Tekrar deneyin.");
    }
  }

  return (
    <div style={{ width: "100%", maxWidth: 400 }}>
      <div style={{ textAlign: "center", marginBottom: 40 }}>
        <div style={{
          width: 56,
          height: 56,
          borderRadius: "var(--radius-md)",
          background: "var(--color-accent-bright)",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          margin: "0 auto 12px",
        }}>
          <Compass size={28} color="var(--color-navy)" strokeWidth={2.25} />
        </div>
        <h1 style={{ fontSize: 28, fontWeight: 700, color: "var(--color-navy)", margin: "0 0 4px" }}>Sosyolobi</h1>
        <p style={{ color: "var(--color-muted-foreground)", fontSize: 15, margin: 0 }}>Etkinlikleri kesfet, insanlarla buluş</p>
      </div>
      <div style={{ background: "var(--color-surface)", borderRadius: "var(--radius-xl)", padding: 32, boxShadow: "var(--shadow-lg)" }}>
        <h2 style={{ fontSize: 22, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 24px" }}>Giris Yap</h2>
        <form onSubmit={handleSubmit(onSubmit)}>
          <div style={{ marginBottom: 20 }}>
            <label style={{ display: "block", fontSize: 14, fontWeight: 500, color: "#374151", marginBottom: 6 }}>Telefon Numarasi</label>
            <input {...register("phoneNumber")} type="tel" placeholder="+90 555 000 00 00" style={{ width: "100%", padding: "12px 16px", border: `1px solid ${errors.phoneNumber ? "var(--color-destructive)" : "var(--color-border)"}`, borderRadius: "var(--radius-md)", fontSize: 15, outline: "none", boxSizing: "border-box", fontFamily: "inherit" }} />
            {errors.phoneNumber && <p style={{ color: "var(--color-destructive)", fontSize: 12, marginTop: 4 }}>{errors.phoneNumber.message}</p>}
          </div>
          <button type="submit" disabled={isSubmitting} style={{ width: "100%", padding: "13px", background: "var(--color-accent)", color: "#fff", border: "none", borderRadius: "var(--radius-md)", fontSize: 15, fontWeight: 600, cursor: isSubmitting ? "not-allowed" : "pointer", opacity: isSubmitting ? 0.7 : 1 }}>
            {isSubmitting ? "Gonderiliyor..." : "Dogrulama Kodu Gonder"}
          </button>
        </form>
      </div>
    </div>
  );
}

export default function LoginPage() {
  return (
    <div style={{ minHeight: "100dvh", background: "linear-gradient(160deg, #fff8ee 0%, #fff3e0 40%, #fafbfd 100%)", display: "flex", alignItems: "center", justifyContent: "center", padding: 24, fontFamily: "var(--font-inter), Inter, ui-sans-serif, system-ui, sans-serif" }}>
      <Suspense fallback={null}><LoginForm /></Suspense>
    </div>
  );
}
