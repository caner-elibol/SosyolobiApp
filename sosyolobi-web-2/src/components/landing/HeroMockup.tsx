"use client";

import { motion, useReducedMotion } from "framer-motion";

const EVENTS = [
  {
    emoji: "⚽",
    title: "Halı Saha",
    place: "Çekmeköy",
    time: "Bugün · 20:00",
    status: "2 kişi aranıyor",
  },
  {
    emoji: "🏃",
    title: "Akşam Koşusu",
    place: "Üsküdar",
    time: "Yarın · 19:30",
    status: "4 kişi katıldı",
  },
  {
    emoji: "🥾",
    title: "Hafta Sonu Doğa Yürüyüşü",
    place: "Beykoz",
    time: "Cumartesi · 09:00",
    status: "3 kişi aranıyor",
  },
];

const AVATAR_INITIALS = ["A", "B", "C"];

export function HeroMockup() {
  const reduceMotion = useReducedMotion();

  return (
    <div className="relative flex justify-center py-8">
      <div
        aria-hidden
        className="absolute -z-10 h-72 w-72 rounded-full blur-3xl"
        style={{ background: "var(--color-soft-orange)", top: "-10%", right: "5%" }}
      />
      <div
        aria-hidden
        className="absolute -z-10 h-56 w-56 rounded-full blur-3xl"
        style={{ background: "var(--color-soft-navy)", bottom: "0%", left: "0%" }}
      />

      <span
        aria-hidden
        className="absolute left-4 top-10 h-3 w-3 rounded-full"
        style={{ background: "var(--color-accent-bright)", animation: "pulse 2.4s ease-in-out infinite" }}
      />
      <span
        aria-hidden
        className="absolute right-6 bottom-16 h-2.5 w-2.5 rounded-full"
        style={{ background: "var(--color-navy)", animation: "pulse 3s ease-in-out infinite" }}
      />

      <div
        className="relative w-full max-w-[300px] overflow-hidden rounded-[32px] border bg-white p-3"
        style={{ borderColor: "var(--color-border)", boxShadow: "var(--shadow-lg)" }}
      >
        <p className="px-2 pb-3 pt-1 text-sm font-bold" style={{ color: "var(--color-foreground)" }}>
          Yakınındaki Etkinlikler
        </p>
        <div className="flex flex-col gap-2">
          {EVENTS.map((event) => (
            <div
              key={event.title}
              className="rounded-2xl border p-3"
              style={{ borderColor: "var(--color-border)", background: "var(--color-soft-navy)" }}
            >
              <div className="flex items-center gap-2 text-sm font-bold" style={{ color: "var(--color-foreground)" }}>
                <span aria-hidden>{event.emoji}</span>
                {event.title}
              </div>
              <p className="mt-0.5 text-xs" style={{ color: "var(--color-muted-foreground)" }}>
                {event.place} · {event.time}
              </p>
              <p className="mt-1 text-xs font-semibold" style={{ color: "var(--color-accent-bright)" }}>
                {event.status}
              </p>
            </div>
          ))}
        </div>
      </div>

      <div className="pointer-events-none absolute -bottom-2 left-1/2 flex -translate-x-1/2 gap-2">
        {AVATAR_INITIALS.map((initial, i) => (
          <motion.div
            key={initial}
            animate={reduceMotion ? undefined : { y: [0, -6, 0] }}
            transition={{ duration: 4, repeat: Infinity, delay: i * 0.4, ease: "easeInOut" }}
            className="flex h-9 w-9 items-center justify-center rounded-full border-2 border-white text-xs font-bold text-white"
            style={{ background: "var(--color-navy)", boxShadow: "var(--shadow-md)" }}
          >
            {initial}
          </motion.div>
        ))}
      </div>
    </div>
  );
}
