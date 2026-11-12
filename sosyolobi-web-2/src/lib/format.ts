import { type UserStatus, type ActivityStatus, type ReportStatus } from "@/types/admin";

export function formatDate(dateStr: string): string {
  return new Date(dateStr).toLocaleDateString("tr-TR", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
}

export function formatDateTime(dateStr: string): string {
  return new Date(dateStr).toLocaleString("tr-TR", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
}

export function formatDistanceMeters(m?: number | null): string | null {
  if (m === undefined || m === null) return null;
  if (m < 10) return "<10 m";
  if (m < 1000) return `${Math.round(m)} m`;
  return `${(m / 1000).toFixed(1)} km`;
}

export function formatRelative(dateStr: string): string {
  const diff = Date.now() - new Date(dateStr).getTime();
  const mins = Math.floor(diff / 60000);
  if (mins < 1) return "az önce";
  if (mins < 60) return `${mins} dk önce`;
  const hours = Math.floor(mins / 60);
  if (hours < 24) return `${hours} sa önce`;
  const days = Math.floor(hours / 24);
  return `${days} gün önce`;
}

export const USER_STATUS_LABEL: Record<UserStatus, string> = {
  1: "Aktif",
  2: "Askıda",
  3: "Silindi",
  4: "Banlı",
};

export const USER_STATUS_COLOR: Record<UserStatus, string> = {
  1: "bg-green-100 text-green-700",
  2: "bg-yellow-100 text-yellow-700",
  3: "bg-gray-100 text-gray-600",
  4: "bg-red-100 text-red-700",
};

export const ACTIVITY_STATUS_LABEL: Record<ActivityStatus, string> = {
  1: "Açık",
  2: "Dolu",
  3: "Tamamlandı",
  4: "İptal",
};

export const ACTIVITY_STATUS_COLOR: Record<ActivityStatus, string> = {
  1: "bg-green-100 text-green-700",
  2: "bg-blue-100 text-blue-700",
  3: "bg-gray-100 text-gray-600",
  4: "bg-red-100 text-red-700",
};

export const REPORT_STATUS_LABEL: Record<ReportStatus, string> = {
  1: "Bekliyor",
  2: "İnceleniyor",
  3: "Çözüldü",
  4: "Reddedildi",
};

export const REPORT_STATUS_COLOR: Record<ReportStatus, string> = {
  1: "bg-orange-100 text-orange-700",
  2: "bg-blue-100 text-blue-700",
  3: "bg-green-100 text-green-700",
  4: "bg-gray-100 text-gray-600",
};
