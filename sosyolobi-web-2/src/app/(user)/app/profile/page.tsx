"use client";

import { useRef, useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { toast } from "sonner";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { TrustBadge } from "@/components/app/TrustBadge";
import { LoadingState } from "@/components/app/LoadingState";
import { useProfile } from "@/hooks/useProfile";
import { useFriends } from "@/hooks/useFriends";
import { clearUserToken } from "@/lib/user-auth";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { Camera, CheckCircle2, ChevronRight, LogOut, MessageSquare, Star, Users, type LucideIcon } from "lucide-react";

const schema = z.object({
  displayName: z.string().min(2, "En az 2 karakter"),
  bio: z.string().max(200).optional(),
});
type FormValues = z.infer<typeof schema>;

export default function ProfilePage() {
  const router = useRouter();
  const { data: profile, isLoading, update, uploadAvatar } = useProfile();
  const { data: friends = [] } = useFriends();
  const [editing, setEditing] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  async function handleAvatarChange(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    e.target.value = "";
    if (!file) return;
    try {
      await uploadAvatar.mutateAsync(file);
      toast.success("Profil fotoğrafı güncellendi.");
    } catch {
      toast.error("Fotoğraf yüklenemedi.");
    }
  }

  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
    values: { displayName: profile?.displayName ?? "", bio: profile?.bio ?? "" },
  });

  async function onSubmit(values: FormValues) {
    try {
      await update.mutateAsync(values);
      toast.success("Profil güncellendi.");
      setEditing(false);
    } catch {
      toast.error("Güncellenemedi.");
    }
  }

  function logout() {
    clearUserToken();
    router.replace("/auth/login");
  }

  if (isLoading) return <AppShell><LoadingState /></AppShell>;
  if (!profile) return <AppShell><div style={{ padding: 24, color: "var(--color-destructive)" }}>Profil yüklenemedi.</div></AppShell>;

  const stats: { label: string; value: string | number; icon: LucideIcon }[] = [
    { label: "Tamamlanan", value: profile.completedActivityCount, icon: CheckCircle2 },
    { label: "Değerlendirme", value: profile.averageRating.toFixed(1), icon: Star },
    { label: "Yorum Sayısı", value: profile.reviewCount, icon: MessageSquare },
  ];

  return (
    <AppShell>
      <div style={{ maxWidth: 640, margin: "0 auto", padding: "24px 16px 40px" }}>
        <div style={{
          background: "var(--color-surface)",
          borderRadius: "var(--radius-xl)",
          padding: 24,
          border: "1px solid var(--color-border)",
          marginBottom: 16,
          display: "flex",
          alignItems: "flex-start",
          gap: 16,
        }}>
          <div style={{ position: "relative", flexShrink: 0 }}>
            <UserAvatar displayName={profile.displayName} avatarUrl={profile.avatarUrl} size={72} />
            <button
              onClick={() => fileInputRef.current?.click()}
              disabled={uploadAvatar.isPending}
              style={{
                position: "absolute",
                bottom: -2,
                right: -2,
                width: 28,
                height: 28,
                borderRadius: "50%",
                background: "var(--color-accent)",
                border: "2px solid #fff",
                color: "#fff",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                cursor: "pointer",
              }}
              aria-label="Fotoğrafı değiştir"
            >
              {uploadAvatar.isPending ? "…" : <Camera size={14} />}
            </button>
            <input
              ref={fileInputRef}
              type="file"
              accept="image/jpeg,image/png,image/webp"
              onChange={handleAvatarChange}
              style={{ display: "none" }}
            />
          </div>
          <div style={{ flex: 1 }}>
            <h1 style={{ fontSize: 20, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 4px" }}>
              {profile.displayName}
            </h1>
            {profile.bio && <p style={{ fontSize: 14, color: "var(--color-muted-foreground)", margin: "0 0 8px" }}>{profile.bio}</p>}
            <TrustBadge isPhoneVerified={profile.isPhoneVerified} rating={profile.averageRating} />
          </div>
          <button
            onClick={() => setEditing(!editing)}
            style={{
              padding: "8px 14px",
              background: "#F3F4F6",
              border: "none",
              borderRadius: "var(--radius-sm)",
              fontSize: 13,
              cursor: "pointer",
              color: "#374151",
            }}
          >
            {editing ? "İptal" : "Düzenle"}
          </button>
        </div>

        <div style={{
          display: "grid",
          gridTemplateColumns: "1fr 1fr 1fr",
          gap: 12,
          marginBottom: 16,
        }}>
          {stats.map((stat) => (
            <div key={stat.label} style={{
              background: "var(--color-surface)",
              border: "1px solid var(--color-border)",
              borderRadius: "var(--radius-lg)",
              padding: "16px",
              textAlign: "center",
            }}>
              <stat.icon size={20} color="var(--color-accent)" style={{ marginBottom: 6 }} />
              <div style={{ fontSize: 18, fontWeight: 700, color: "var(--color-foreground)" }}>{stat.value}</div>
              <div style={{ fontSize: 11, color: "var(--color-muted-foreground)", marginTop: 2 }}>{stat.label}</div>
            </div>
          ))}
        </div>

        <Link href="/app/friends" style={{
          display: "flex",
          alignItems: "center",
          gap: 12,
          background: "var(--color-surface)",
          border: "1px solid var(--color-border)",
          borderRadius: "var(--radius-lg)",
          padding: "14px 16px",
          marginBottom: 16,
          textDecoration: "none",
        }}>
          <span style={{
            width: 36, height: 36, borderRadius: "50%",
            background: "var(--color-accent-soft-bg)",
            display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0,
          }}>
            <Users size={17} color="var(--color-accent-soft-fg)" />
          </span>
          <span style={{ flex: 1, fontSize: 14, fontWeight: 600, color: "var(--color-foreground)" }}>
            Arkadaşlarım {friends.length > 0 && <span style={{ color: "var(--color-muted-foreground)", fontWeight: 500 }}>({friends.length})</span>}
          </span>
          <ChevronRight size={16} color="var(--color-muted-foreground)" />
        </Link>

        {editing && (
          <div style={{
            background: "var(--color-surface)",
            borderRadius: "var(--radius-xl)",
            padding: 24,
            border: "1px solid var(--color-border)",
            marginBottom: 16,
          }}>
            <h3 style={{ fontSize: 16, fontWeight: 700, margin: "0 0 16px", color: "var(--color-foreground)" }}>Profili Düzenle</h3>
            <form onSubmit={handleSubmit(onSubmit)}>
              <div style={{ marginBottom: 14 }}>
                <label style={{ fontSize: 13, fontWeight: 500, color: "#374151", display: "block", marginBottom: 5 }}>
                  İsim Soyisim
                </label>
                <input
                  {...register("displayName")}
                  style={{
                    width: "100%",
                    padding: "11px 14px",
                    border: `1px solid ${errors.displayName ? "var(--color-destructive)" : "var(--color-border)"}`,
                    borderRadius: "var(--radius-sm)",
                    fontSize: 14,
                    outline: "none",
                    boxSizing: "border-box",
                    fontFamily: "inherit",
                  }}
                />
                {errors.displayName && <p style={{ fontSize: 12, color: "var(--color-destructive)", marginTop: 3 }}>{errors.displayName.message}</p>}
              </div>
              <div style={{ marginBottom: 16 }}>
                <label style={{ fontSize: 13, fontWeight: 500, color: "#374151", display: "block", marginBottom: 5 }}>
                  Hakkımda
                </label>
                <textarea
                  {...register("bio")}
                  rows={3}
                  style={{
                    width: "100%",
                    padding: "11px 14px",
                    border: "1px solid var(--color-border)",
                    borderRadius: "var(--radius-sm)",
                    fontSize: 14,
                    outline: "none",
                    resize: "vertical",
                    boxSizing: "border-box",
                    fontFamily: "inherit",
                  }}
                />
              </div>
              <button
                type="submit"
                disabled={isSubmitting}
                style={{
                  width: "100%",
                  padding: "12px",
                  background: "var(--color-accent)",
                  color: "#fff",
                  border: "none",
                  borderRadius: "var(--radius-sm)",
                  fontSize: 14,
                  fontWeight: 600,
                  cursor: "pointer",
                  opacity: isSubmitting ? 0.7 : 1,
                }}
              >
                {isSubmitting ? "Kaydediliyor..." : "Kaydet"}
              </button>
            </form>
          </div>
        )}

        <button
          onClick={logout}
          style={{
            width: "100%",
            padding: "12px",
            background: "none",
            border: "1px solid var(--color-border)",
            borderRadius: "var(--radius-md)",
            fontSize: 14,
            color: "var(--color-destructive)",
            cursor: "pointer",
            fontWeight: 500,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            gap: 8,
          }}
        >
          <LogOut size={15} /> Çıkış Yap
        </button>
      </div>
    </AppShell>
  );
}
