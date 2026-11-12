import { ScrollReveal } from "./ScrollReveal";

const FILTERS = ["Kategori", "Tarih", "Mesafe"];

const PINS = [
  { top: "30%", left: "22%", pulse: true },
  { top: "48%", left: "55%", pulse: false },
  { top: "65%", left: "35%", pulse: false },
  { top: "22%", left: "72%", pulse: true },
];

export function MapDiscoverySection() {
  return (
    <section aria-labelledby="map-discovery-heading" className="mx-auto max-w-[1280px] px-6 py-16 md:py-24">
      <ScrollReveal>
        <div className="mx-auto max-w-2xl text-center">
          <h2 id="map-discovery-heading" className="text-3xl font-extrabold md:text-4xl" style={{ color: "var(--color-navy)" }}>
            Yakınında ne var?
          </h2>
          <p className="mt-4 text-lg" style={{ color: "var(--color-muted-foreground)" }}>
            Konumuna göre sana yakın etkinlikleri keşfet. Haritadan bak, etkinliği seç ve katıl.
          </p>
        </div>
      </ScrollReveal>

      <ScrollReveal delay={0.1}>
        <div
          className="mt-10 overflow-hidden rounded-3xl border"
          style={{ borderColor: "var(--color-border)", boxShadow: "var(--shadow-md)" }}
        >
          <div className="flex flex-wrap gap-2 border-b p-4" style={{ borderColor: "var(--color-border)" }}>
            {FILTERS.map((filter) => (
              <span
                key={filter}
                className="rounded-full border px-4 py-2 text-sm font-semibold"
                style={{ borderColor: "var(--color-border)", color: "var(--color-foreground)" }}
              >
                {filter}
              </span>
            ))}
          </div>

          <div
            className="relative h-[380px] md:h-[500px]"
            style={{ background: "var(--color-soft-navy)" }}
          >
            {PINS.map((pin, i) => (
              <span
                key={i}
                aria-hidden
                className="absolute h-3.5 w-3.5 -translate-x-1/2 -translate-y-1/2 rounded-full border-2 border-white"
                style={{
                  top: pin.top,
                  left: pin.left,
                  background: "var(--color-accent-bright)",
                  animation: pin.pulse ? "pulse 2.4s ease-in-out infinite" : undefined,
                  boxShadow: "var(--shadow-sm)",
                }}
              />
            ))}
          </div>
        </div>
      </ScrollReveal>
    </section>
  );
}
