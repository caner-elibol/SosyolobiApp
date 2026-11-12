"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { toast } from "sonner";
import { setToken, getAdminFromToken, isAdminRole } from "@/lib/auth";
import type { AuthResponse, ApiResponse } from "@/types/admin";

const schema = z.object({
  phoneNumber: z.string().min(1, "Telefon numarası zorunludur"),
  password: z.string().min(1, "Şifre zorunludur"),
});
type FormValues = z.infer<typeof schema>;

export default function LoginPage() {
  const router = useRouter();

  useEffect(() => {
    if (getAdminFromToken()) router.replace("/admin/dashboard");
  }, [router]);

  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
  });

  async function onSubmit(values: FormValues) {
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(values),
      });
      const json = (await res.json()) as ApiResponse<AuthResponse>;
      if (!res.ok || !json.success) { toast.error(json.message ?? "Giriş başarısız."); return; }
      if (!isAdminRole(json.data.role)) { toast.error("Bu panele erişim yetkiniz yok."); return; }
      setToken(json.data.accessToken);
      router.replace("/admin/dashboard");
    } catch { toast.error("Sunucuya ulaşılamadı."); }
  }

  const inputStyle: React.CSSProperties = {
    width: "100%", height: 46, borderRadius: 10,
    border: "1px solid #EBEBF0", padding: "0 14px",
    fontSize: 14, color: "#1B1D29", outline: "none",
    backgroundColor: "#F8F9FF",
  };

  return (
    <div style={{
      minHeight: "100vh", display: "flex",
      backgroundColor: "#F4F5F9",
    }}>
      <div style={{
        width: 420, padding: "0 40px",
        display: "flex", flexDirection: "column",
        justifyContent: "center", backgroundColor: "#fff",
        borderRight: "1px solid #F0F1F5",
      }}>
        <div style={{ display: "flex", flexDirection: "column", alignItems: "center", marginBottom: 36 }}>
          <div style={{
            width: 64, height: 64, borderRadius: "50%",
            backgroundColor: "#5B5FE9",
            display: "flex", alignItems: "center", justifyContent: "center",
            marginBottom: 16,
            boxShadow: "0 8px 24px rgba(91,95,233,0.3)",
          }}>
            <span style={{ color: "#fff", fontSize: 24, fontWeight: 800 }}>S</span>
          </div>
          <h1 style={{ fontSize: 24, fontWeight: 700, color: "#1B1D29" }}>Giriş Yap</h1>
          <p style={{ fontSize: 13, color: "#6B7280", marginTop: 6 }}>Admin paneline hoş geldiniz</p>
        </div>

        <form onSubmit={handleSubmit(onSubmit)} style={{ display: "flex", flexDirection: "column", gap: 16 }}>
          <div>
            <label style={{ fontSize: 13, fontWeight: 500, color: "#1B1D29", display: "block", marginBottom: 6 }}>
              Telefon Numarası
            </label>
            <input
              {...register("phoneNumber")}
              placeholder="+905XXXXXXXXX"
              style={{ ...inputStyle, borderColor: errors.phoneNumber ? "#B91C1C" : "#EBEBF0" }}
            />
            {errors.phoneNumber && <p style={{ fontSize: 12, color: "#B91C1C", marginTop: 4 }}>{errors.phoneNumber.message}</p>}
          </div>

          <div>
            <label style={{ fontSize: 13, fontWeight: 500, color: "#1B1D29", display: "block", marginBottom: 6 }}>
              Şifre
            </label>
            <input
              {...register("password")}
              type="password"
              placeholder="••••••••"
              style={{ ...inputStyle, borderColor: errors.password ? "#B91C1C" : "#EBEBF0" }}
            />
            {errors.password && <p style={{ fontSize: 12, color: "#B91C1C", marginTop: 4 }}>{errors.password.message}</p>}
          </div>

          <button
            type="submit"
            disabled={isSubmitting}
            style={{
              width: "100%", height: 48, borderRadius: 10, border: "none",
              backgroundColor: "#5B5FE9", color: "#fff",
              fontSize: 15, fontWeight: 600, cursor: isSubmitting ? "not-allowed" : "pointer",
              marginTop: 8, opacity: isSubmitting ? 0.7 : 1,
              transition: "opacity 0.15s",
            }}
          >
            {isSubmitting ? "Giriş yapılıyor…" : "Giriş Yap"}
          </button>
        </form>
      </div>

      <div style={{
        flex: 1, display: "flex", alignItems: "center", justifyContent: "center",
        background: "radial-gradient(ellipse at 50% 0%, rgba(91,95,233,0.08) 0%, transparent 70%)",
      }}>
        <div style={{ textAlign: "center" }}>
          <div style={{
            width: 120, height: 120, borderRadius: "50%",
            background: "linear-gradient(135deg, #5B5FE9 0%, #7B61FF 100%)",
            margin: "0 auto 24px",
            display: "flex", alignItems: "center", justifyContent: "center",
            boxShadow: "0 24px 64px rgba(91,95,233,0.3)",
          }}>
            <span style={{ color: "#fff", fontSize: 48, fontWeight: 800 }}>S</span>
          </div>
          <h2 style={{ fontSize: 28, fontWeight: 700, color: "#1B1D29" }}>Sosyolobi</h2>
          <p style={{ fontSize: 15, color: "#6B7280", marginTop: 8 }}>Operations Center</p>
        </div>
      </div>
    </div>
  );
}
