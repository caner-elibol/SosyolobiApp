import { Calendar, MapPin, Users, Sparkles } from "lucide-react";
import { ScrollReveal } from "./ScrollReveal";

const STEPS = [
  {
    number: "01",
    icon: Calendar,
    title: "Ne yapmak istediğini seç",
    description: "Futbol, yürüyüş, masa tenisi, kamp, oyun, konser veya başka bir etkinlik.",
  },
  {
    number: "02",
    icon: MapPin,
    title: "Etkinliği oluştur veya keşfet",
    description: "Yakınındaki etkinlikleri haritadan keşfet veya kendi etkinliğini oluştur.",
  },
  {
    number: "03",
    icon: Users,
    title: "İnsanlarla eşleş",
    description: "Katılmak istediğin etkinliğe başvur. Etkinlik sahibi başvurunu onaylasın.",
  },
  {
    number: "04",
    icon: Sparkles,
    title: "Birlikte yap",
    description: "Planı netleştir. Buluş. Etkinliği gerçekleştir. Yeni insanlarla tanış.",
  },
];

export function HowItWorks() {
  return (
    <section id="nasil-calisir" aria-labelledby="how-it-works-heading" className="mx-auto max-w-[1280px] px-6 py-16 md:py-24">
      <ScrollReveal>
        <h2
          id="how-it-works-heading"
          className="text-center text-3xl font-extrabold md:text-4xl"
          style={{ color: "var(--color-navy)" }}
        >
          Sosyolobi nasıl çalışır?
        </h2>
      </ScrollReveal>

      <div className="mt-12 grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">
        {STEPS.map((step, i) => (
          <ScrollReveal key={step.number} delay={i * 0.08}>
            <div className="flex flex-col items-start gap-3">
              <div className="flex items-center gap-3">
                <span
                  className="flex h-11 w-11 items-center justify-center rounded-full"
                  style={{ background: "var(--color-soft-orange)" }}
                >
                  <step.icon size={20} color="var(--color-accent-bright)" />
                </span>
                <span className="text-sm font-bold" style={{ color: "var(--color-muted-foreground)" }}>
                  {step.number}
                </span>
              </div>
              <h3 className="text-lg font-bold" style={{ color: "var(--color-foreground)" }}>
                {step.title}
              </h3>
              <p className="text-sm" style={{ color: "var(--color-muted-foreground)" }}>
                {step.description}
              </p>
            </div>
          </ScrollReveal>
        ))}
      </div>
    </section>
  );
}
