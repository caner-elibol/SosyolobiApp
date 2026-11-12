"use client";

import { Suspense, useEffect, useRef, useState } from "react";
import { use } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { toast } from "sonner";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { ChatPanel } from "@/components/app/ChatPanel";
import { JoinActivityModal } from "@/components/app/JoinActivityModal";
import { ParticipantsModal } from "@/components/app/ParticipantsModal";
import { useActivity } from "@/hooks/useCreateActivity";
import { useJoinRequest } from "@/hooks/useJoinRequest";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";
import { formatDistanceMeters } from "@/lib/format";
import { resolveImageUrl } from "@/lib/image-url";
import { ActivityStatus, ActivityRequestStatus } from "@/types/user";
import { getUserFromToken } from "@/lib/user-auth";
import {
  ArrowLeft,
  Calendar,
  ChevronRight,
  Clock,
  Key,
  MapPin,
  Target,
  Users,
  Wallet,
  XCircle,
  type LucideIcon,
} from "lucide-react";

const SKILL_LABELS: Record<number, string> = {
  0: "Herkes", 1: "Başlangıç", 2: "Orta", 3: "İleri",
};
const GENDER_LABELS: Record<number, string> = {
  0: "Herkes", 1: "Erkek", 2: "Kadın", 3: "Karışık",
};

function formatDate(iso: string) {
  const d = new Date(iso);
  const today = new Date();
  const isToday = d.toDateString() === today.toDateString();
  const day = isToday ? "Bugün" : d.toLocaleDateString("tr-TR", { weekday: "long", day: "numeric", month: "long" });
  return `${day} ${d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" })}`;
}

function formatCountdown(iso: string) {
  const diffMs = new Date(iso).getTime() - Date.now();
  if (diffMs <= 0) return "Başladı";
  const minutes = Math.floor(diffMs / 60_000);
  const hours = Math.floor(minutes / 60);
  const days = Math.floor(hours / 24);
  if (days > 0) return `${days} gün${hours % 24 > 0 ? ` ${hours % 24} sa` : ""} kaldı`;
  if (hours > 0) return `${hours} sa ${minutes % 60} dk kaldı`;
  return `${minutes} dk kaldı`;
}

export default function ActivityDetailPage({ params }: { params: Promise<{ id: string }> }) {
  return (
    <Suspense fallback={<AppShell><LoadingState message="Etkinlik yükleniyor..." /></AppShell>}>
      <ActivityDetailPageInner params={params} />
    </Suspense>
  );
}

function ActivityDetailPageInner({ params }: { params: Promise<{ id: string }> }) {
  const { id } = use(params);
  const router = useRouter();
  const searchParams = useSearchParams();
  const { data: activity, isLoading, error } = useActivity(id);
  const { join } = useJoinRequest(id);
  const [showJoinModal, setShowJoinModal] = useState(false);
  const [showParticipantsModal, setShowParticipantsModal] = useState(false);
  const chatRef = useRef<HTMLDivElement>(null);

  const shouldFocusChat = searchParams.get("chat") === "1";

  useEffect(() => {
    if (!shouldFocusChat || !activity) return;
    const timer = setTimeout(() => {
      chatRef.current?.scrollIntoView({ behavior: "smooth", block: "start" });
    }, 200);
    return () => clearTimeout(timer);
  }, [shouldFocusChat, activity]);

  if (isLoading) return <AppShell><LoadingState message="Etkinlik yükleniyor..." /></AppShell>;
  if (error || !activity) return <AppShell><EmptyState icon={XCircle} title="Etkinlik bulunamadı" /></AppShell>;

  const CategoryIcon = getCategoryIcon(activity.categoryName);
  const categoryColor = getCategoryColor(activity.categoryName);
  const totalSpots = activity.neededPeopleCount + 1;
  const dist = formatDistanceMeters(activity.distanceMeters);
  const isCancelled = activity.status === ActivityStatus.Cancelled;
  const isFull = activity.status === ActivityStatus.Full;
  const currentUserId = getUserFromToken()?.sub;
  const isParticipant = !!currentUserId && activity.participants.some((p) => p.userId === currentUserId);
  const hasPendingRequest = activity.myRequestStatus === ActivityRequestStatus.Pending;
  const priceLabel = activity.pricePerPerson && activity.pricePerPerson > 0 ? `${activity.pricePerPerson} ₺` : "Ücretsiz";
  const spotsLabel = `${activity.currentPeopleCount} / ${totalSpots} kişi`;
  const heroImageUrl = resolveImageUrl(activity.categoryImageUrl);

  async function handleJoin() {
    try {
      await join.mutateAsync(undefined);
      toast.success("Katılım isteği gönderildi!");
      setShowJoinModal(false);
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "İstek gönderilemedi.");
    }
  }

  const canJoin = !isCancelled && !isFull && !isParticipant;

  return (
    <AppShell>
      <div style={{ maxWidth: 680, margin: "0 auto", padding: "0 0 32px" }}>
        <div style={{
          position: "relative",
          height: 180,
          background: heroImageUrl
            ? `linear-gradient(180deg, rgba(0,0,0,0.15) 0%, rgba(0,0,0,0.05) 40%, rgba(0,0,0,0.25) 100%), url(${heroImageUrl}) center/cover no-repeat`
            : `linear-gradient(135deg, ${categoryColor} 0%, color-mix(in srgb, ${categoryColor} 70%, black) 100%)`,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}>
          <button
            onClick={() => router.back()}
            aria-label="Geri"
            style={{
              position: "absolute",
              top: 16,
              left: 16,
              width: 36,
              height: 36,
              borderRadius: "50%",
              background: "rgba(255,255,255,0.92)",
              border: "none",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              cursor: "pointer",
              boxShadow: "var(--shadow-md)",
            }}
          >
            <ArrowLeft size={18} color="var(--color-foreground)" />
          </button>
          {!heroImageUrl && <CategoryIcon size={56} color="rgba(255,255,255,0.85)" strokeWidth={1.75} />}
        </div>

        <div style={{ padding: "16px 16px 0" }}>
          <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10, marginBottom: 14 }}>
            <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, fontWeight: 600, color: "var(--color-accent)" }}>
              <Calendar size={14} /> {formatDate(activity.eventDate)}
            </div>
            {!isCancelled && (
              <div style={{ display: "flex", alignItems: "center", gap: 5, fontSize: 12, fontWeight: 600, color: "var(--color-muted-foreground)" }}>
                <Clock size={13} /> {formatCountdown(activity.eventDate)}
              </div>
            )}
          </div>

          <div style={{ display: "flex", alignItems: "flex-start", justifyContent: "space-between", gap: 12, marginBottom: 16 }}>
            <div style={{ flex: 1, minWidth: 0 }}>
              <h1 style={{
                fontSize: 21,
                fontWeight: 700,
                color: "var(--color-foreground)",
                margin: "0 0 6px",
                display: "-webkit-box",
                WebkitLineClamp: 2,
                WebkitBoxOrient: "vertical",
                overflow: "hidden",
              }}>{activity.title}</h1>
              {activity.description && (
                <p style={{ fontSize: 15, color: "var(--color-foreground)", lineHeight: 1.4, margin: "0 0 6px" }}>{activity.description}</p>
              )}
              <Link
                href={`/app/profile/${activity.createdByUserId}`}
                style={{ display: "inline-block", fontSize: 13, color: "var(--color-muted-foreground)", marginBottom: 8, textDecoration: "none" }}
              >
                Düzenleyen: <span style={{ fontWeight: 600, color: "var(--color-foreground)" }}>{activity.createdByDisplayName}</span>
              </Link>
              <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, color: "var(--color-muted-foreground)", marginBottom: 8 }}>
                <MapPin size={14} /> {activity.addressText}
                {dist && <span>· {dist}</span>}
              </div>
              <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
                {activity.participants.length > 0 && (
                  <div style={{ display: "flex", marginLeft: 4 }}>
                    {activity.participants.slice(0, 4).map((p, i) => (
                      <span key={p.userId} style={{ marginLeft: i === 0 ? 0 : -8, border: "2px solid var(--color-background)", borderRadius: "50%" }}>
                        <UserAvatar displayName={p.displayName} avatarUrl={p.avatarUrl} size={26} />
                      </span>
                    ))}
                  </div>
                )}
                <span style={{ fontSize: 13, fontWeight: 600, color: "var(--color-foreground)" }}>
                  {activity.currentPeopleCount} / {totalSpots} katılıyor
                </span>
              </div>
            </div>

            <div style={{ display: "flex", flexDirection: "column", alignItems: "flex-end", gap: 8, flexShrink: 0 }}>
              {hasPendingRequest ? (
                <span style={{
                  display: "inline-flex",
                  alignItems: "center",
                  gap: 6,
                  padding: "8px 16px",
                  background: "var(--color-muted-background, #F3F4F6)",
                  color: "var(--color-muted-foreground)",
                  border: "1px solid var(--color-border)",
                  borderRadius: "var(--radius-full)",
                  fontSize: 13,
                  fontWeight: 600,
                  whiteSpace: "nowrap",
                }}>
                  <Users size={14} /> İstek Bekliyor
                </span>
              ) : canJoin ? (
                <button
                  onClick={() => setShowJoinModal(true)}
                  style={{
                    display: "inline-flex",
                    alignItems: "center",
                    gap: 6,
                    padding: "8px 20px",
                    background: "var(--color-accent)",
                    color: "#fff",
                    border: "none",
                    borderRadius: "var(--radius-full)",
                    fontSize: 14,
                    fontWeight: 700,
                    cursor: "pointer",
                    boxShadow: "var(--shadow-sm)",
                    whiteSpace: "nowrap",
                  }}
                >
                  <Users size={15} /> Katıl
                </button>
              ) : null}

              <div style={{ display: "flex", flexWrap: "wrap", justifyContent: "flex-end", gap: 6, maxWidth: 200 }}>
                <span style={{
                  display: "inline-flex",
                  alignItems: "center",
                  padding: "3px 10px",
                  borderRadius: "var(--radius-full)",
                  background: `color-mix(in srgb, ${categoryColor} 14%, white)`,
                  color: categoryColor,
                  fontSize: 12,
                  fontWeight: 600,
                  whiteSpace: "nowrap",
                }}>
                  {activity.categoryName}
                </span>
                {isCancelled ? (
                  <InfoChip icon={XCircle} tone="muted">İptal edildi</InfoChip>
                ) : isFull ? (
                  <InfoChip icon={Users} tone="muted">Dolu</InfoChip>
                ) : (
                  <InfoChip icon={Users} tone="success">Açık</InfoChip>
                )}
                <InfoChip icon={Wallet}>{priceLabel}</InfoChip>
                <InfoChip icon={Target}>{SKILL_LABELS[activity.skillLevel] ?? "Herkes"}</InfoChip>
                <InfoChip icon={Users}>{GENDER_LABELS[activity.genderPreference] ?? "Herkes"}</InfoChip>
              </div>
            </div>
          </div>

          {activity.addressDetailPrivate && (
            <>
              <SectionTitle>Konum</SectionTitle>
              <div style={{
                background: "#F9FAFB",
                borderRadius: "var(--radius-lg)",
                padding: "12px 14px",
                marginBottom: 16,
              }}>
                <div style={{ display: "flex", alignItems: "center", gap: 5, fontSize: 12, fontWeight: 600, color: "var(--color-success)" }}>
                  <Key size={12} /> {activity.addressDetailPrivate}
                </div>
                <p style={{ fontSize: 11, color: "var(--color-muted-foreground)", margin: "4px 0 0" }}>
                  Bu adres detayı sadece onaylı katılımcılara gösterilir.
                </p>
              </div>
            </>
          )}

          {activity.participants.length > 0 && (
            <button
              onClick={() => setShowParticipantsModal(true)}
              style={{
                display: "flex",
                alignItems: "center",
                justifyContent: "space-between",
                width: "100%",
                background: "var(--color-surface)",
                borderRadius: "var(--radius-lg)",
                border: "1px solid var(--color-border)",
                padding: "12px 14px",
                marginBottom: 16,
                cursor: "pointer",
                fontFamily: "inherit",
              }}
            >
              <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
                <div style={{ display: "flex" }}>
                  {activity.participants.slice(0, 4).map((p, i) => (
                    <span key={p.userId} style={{ marginLeft: i === 0 ? 0 : -8, border: "2px solid var(--color-surface)", borderRadius: "50%" }}>
                      <UserAvatar displayName={p.displayName} avatarUrl={p.avatarUrl} size={28} />
                    </span>
                  ))}
                </div>
                <span style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)" }}>
                  Katılımcılar · {activity.participants.length} kişi
                </span>
              </div>
              <ChevronRight size={16} color="var(--color-muted-foreground)" />
            </button>
          )}
        </div>

        <div style={{ padding: "0 16px" }}>
        {isFull && (
          <div style={{
            background: "#F3F4F6",
            borderRadius: "var(--radius-md)",
            padding: "14px 20px",
            textAlign: "center",
            color: "var(--color-muted-foreground)",
            fontSize: 14,
            marginBottom: 12,
          }}>
            Kontenjan doldu
          </div>
        )}

        {isCancelled && (
          <div style={{
            background: "var(--color-destructive-bg)",
            borderRadius: "var(--radius-md)",
            padding: "14px 20px",
            textAlign: "center",
            color: "var(--color-destructive)",
            fontSize: 14,
            marginBottom: 12,
          }}>
            Bu etkinlik iptal edildi
          </div>
        )}

        {isParticipant && <div ref={chatRef}><ChatPanel activityId={id} /></div>}
        </div>
      </div>

      {showJoinModal && (
        <JoinActivityModal
          title={activity.title}
          categoryName={activity.categoryName}
          categoryColor={categoryColor}
          CategoryIcon={CategoryIcon}
          dateLabel={formatDate(activity.eventDate)}
          addressText={activity.addressText}
          priceLabel={priceLabel}
          spotsLabel={spotsLabel}
          isPending={join.isPending}
          onConfirm={handleJoin}
          onClose={() => setShowJoinModal(false)}
        />
      )}

      {showParticipantsModal && (
        <ParticipantsModal
          participants={activity.participants}
          currentUserId={currentUserId}
          onClose={() => setShowParticipantsModal(false)}
        />
      )}
    </AppShell>
  );
}

function SectionTitle({ children, noMargin }: { children: React.ReactNode; noMargin?: boolean }) {
  return (
    <h2 style={{ fontSize: 15, fontWeight: 700, color: "var(--color-foreground)", margin: noMargin ? 0 : "0 0 10px" }}>
      {children}
    </h2>
  );
}

function InfoChip({ icon: Icon, children, tone }: { icon: LucideIcon; children: React.ReactNode; tone?: "success" | "muted" }) {
  const color = tone === "success" ? "var(--color-success)" : tone === "muted" ? "var(--color-muted-foreground)" : "#374151";
  const background = tone === "success" ? "var(--color-success-bg)" : "#F3F4F6";
  return (
    <span style={{
      display: "inline-flex",
      alignItems: "center",
      gap: 4,
      padding: "4px 9px",
      background,
      borderRadius: "var(--radius-full)",
      fontSize: 11,
      color,
      fontWeight: tone ? 600 : 400,
    }}>
      <Icon size={11} /> {children}
    </span>
  );
}
