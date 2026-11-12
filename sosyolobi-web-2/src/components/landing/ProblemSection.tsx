import { ArrowDown, Mountain, Home, Ticket, Footprints } from "lucide-react";
import { ScrollReveal } from "./ScrollReveal";

const SCENARIOS = [
  { icon: Mountain, text: "Hafta sonu Uludağ'a gitmek istiyorsun ama tek başına gitmek istemiyorsun." },
  { icon: Home, text: "Yeni bir şehre taşındın ve çevrende kimseyi tanımıyorsun." },
  { icon: Ticket, text: "Konser bileti aldın ama beraber gidecek kimse yok." },
  { icon: Footprints, text: "Akşam koşmak istiyorsun ama tek başına motivasyon yok." },
];

export function ProblemSection() {
  return (
    <section
      aria-labelledby="problem-heading"
      className="px-6 py-16 md:py-24"
      style={{ background: "var(--color-soft-navy)" }}
    >
      <div className="mx-auto max-w-[1280px]">
        <ScrollReveal>
          <h2 id="problem-heading" className="text-center text-3xl font-extrabold md:text-4xl" style={{ color: "var(--color-navy)" }}>
            Bazen tek eksik şey bir kişi.
          </h2>
        </ScrollReveal>

        <ScrollReveal delay={0.1}>
          <div className="mx-auto mt-10 flex max-w-sm flex-col items-center gap-2 text-center">
            <p className="font-semibold" style={{ color: "var(--color-foreground)" }}>
              Bu akşam halı saha var.
              <br />
              Ama 2 kişi eksik.
            </p>
            <ArrowDown size={20} color="var(--color-muted-foreground)" />
            <p className="text-lg font-extrabold" style={{ color: "var(--color-accent-bright)" }}>
              Sosyolobi
            </p>
            <ArrowDown size={20} color="var(--color-muted-foreground)" />
            <p className="font-semibold" style={{ color: "var(--color-foreground)" }}>
              Yakınında oynayacak 2 kişi bulundu.
            </p>
          </div>
        </ScrollReveal>

        <div className="mt-14 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {SCENARIOS.map((scenario, i) => (
            <ScrollReveal key={scenario.text} delay={i * 0.08}>
              <div
                className="flex h-full flex-col items-start gap-3 rounded-2xl border bg-white p-5"
                style={{ borderColor: "var(--color-border)" }}
              >
                <scenario.icon size={22} color="var(--color-accent-bright)" />
                <p className="text-sm" style={{ color: "var(--color-foreground)" }}>
                  {scenario.text}
                </p>
              </div>
            </ScrollReveal>
          ))}
        </div>
      </div>
    </section>
  );
}
