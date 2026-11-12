import { ScrollReveal } from "./ScrollReveal";

const CATEGORIES = [
  { emoji: "⚽", label: "Spor" },
  { emoji: "🥾", label: "Doğa" },
  { emoji: "🎮", label: "Oyun" },
  { emoji: "🎵", label: "Müzik" },
  { emoji: "🎬", label: "Sinema" },
  { emoji: "☕", label: "Sosyal" },
  { emoji: "✈️", label: "Seyahat" },
  { emoji: "🎨", label: "Sanat" },
];

export function CategoriesSection() {
  return (
    <section aria-labelledby="categories-heading" className="mx-auto max-w-[1280px] px-6 py-16 md:py-24">
      <ScrollReveal>
        <h2 id="categories-heading" className="text-center text-3xl font-extrabold md:text-4xl" style={{ color: "var(--color-navy)" }}>
          Ne yapmak istersin?
        </h2>
      </ScrollReveal>

      <div className="mt-12 grid grid-cols-2 gap-4 md:grid-cols-4">
        {CATEGORIES.map((cat, i) => (
          <ScrollReveal key={cat.label} delay={i * 0.04}>
            <div
              className="flex flex-col items-center gap-2 rounded-[20px] border bg-white p-6 text-center transition-all hover:-translate-y-0.5 hover:border-[var(--color-accent-bright)]"
              style={{ borderColor: "var(--color-border)" }}
            >
              <span className="text-3xl" aria-hidden>
                {cat.emoji}
              </span>
              <span className="text-sm font-bold" style={{ color: "var(--color-foreground)" }}>
                {cat.label}
              </span>
            </div>
          </ScrollReveal>
        ))}
      </div>
    </section>
  );
}
