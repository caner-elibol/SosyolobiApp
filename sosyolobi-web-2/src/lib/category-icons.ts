import {
  Bike,
  Coffee,
  Dices,
  Footprints,
  Goal,
  MapPin,
  Mountain,
  MountainSnow,
  Music,
  Target,
  Tent,
  Volleyball,
  CircleDot,
  type LucideIcon,
} from "lucide-react";

export const CATEGORY_ICONS: Record<string, LucideIcon> = {
  "Futbol": Goal,
  "Basketbol": Target,
  "Voleybol": Volleyball,
  "Tenis": CircleDot,
  "Koşu": Footprints,
  "Bisiklet": Bike,
  "Yürüyüş": Mountain,
  "Kamp": Tent,
  "Kayak": MountainSnow,
  "Masa Oyunu": Dices,
  "Konser": Music,
  "Kahve & Sosyal Buluşma": Coffee,
  "Diğer": MapPin,
};

export function getCategoryIcon(categoryName: string): LucideIcon {
  return CATEGORY_ICONS[categoryName] ?? MapPin;
}

const CATEGORY_COLORS: Record<string, string> = {
  "Futbol": "#2EA86F",
  "Basketbol": "#E8740C",
  "Voleybol": "#2563EB",
  "Tenis": "#CA8A04",
  "Koşu": "#DC2626",
  "Bisiklet": "#8454D9",
  "Yürüyüş": "#8454D9",
  "Kamp": "#E8740C",
  "Kayak": "#2563EB",
  "Masa Oyunu": "#B45309",
  "Konser": "#E94C79",
  "Kahve & Sosyal Buluşma": "#9A3412",
  "Diğer": "#6B7280",
};

export function getCategoryColor(categoryName: string, override?: string): string {
  return override || CATEGORY_COLORS[categoryName] || "#6B7280";
}
