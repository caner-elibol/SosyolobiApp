export type DateFilterKey = "all" | "today" | "week" | "month";

export const DATE_FILTER_OPTIONS: { label: string; value: DateFilterKey }[] = [
  { label: "Tümü", value: "all" },
  { label: "Bugün", value: "today" },
  { label: "Bu Hafta", value: "week" },
  { label: "Bu Ay", value: "month" },
];

function startOfDay(d: Date) {
  const r = new Date(d);
  r.setHours(0, 0, 0, 0);
  return r;
}

function endOfDay(d: Date) {
  const r = new Date(d);
  r.setHours(23, 59, 59, 999);
  return r;
}

function startOfWeek(d: Date) {
  const r = startOfDay(d);
  const day = (r.getDay() + 6) % 7;
  r.setDate(r.getDate() - day);
  return r;
}

function endOfWeek(d: Date) {
  const r = startOfWeek(d);
  r.setDate(r.getDate() + 6);
  return endOfDay(r);
}

function startOfMonth(d: Date) {
  return startOfDay(new Date(d.getFullYear(), d.getMonth(), 1));
}

function endOfMonth(d: Date) {
  return endOfDay(new Date(d.getFullYear(), d.getMonth() + 1, 0));
}

export function getDateRange(key: DateFilterKey, now: Date = new Date()): { fromDate?: string; toDate?: string } {
  switch (key) {
    case "today":
      return { fromDate: startOfDay(now).toISOString(), toDate: endOfDay(now).toISOString() };
    case "week":
      return { fromDate: startOfWeek(now).toISOString(), toDate: endOfWeek(now).toISOString() };
    case "month":
      return { fromDate: startOfMonth(now).toISOString(), toDate: endOfMonth(now).toISOString() };
    default:
      return {};
  }
}

export function isWeekendDate(iso: string): boolean {
  const day = new Date(iso).getDay();
  return day === 0 || day === 6;
}
