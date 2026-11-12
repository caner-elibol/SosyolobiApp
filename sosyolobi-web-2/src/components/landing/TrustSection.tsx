import { ShieldCheck, Star, MessageSquare, Lock, Clock } from "lucide-react";
import { ScrollReveal } from "./ScrollReveal";

const ITEMS = [
  {
    icon: ShieldCheck,
    title: "Telefon doğrulama",
    description: "Gerçek kullanıcılar için telefon doğrulaması.",
  },
  {
    icon: Star,
    title: "Profil ve puan sistemi",
    description: "Etkinliklerden sonra kullanıcılar birbirlerini değerlendirebilir.",
  },
  {
    icon: MessageSquare,
    title: "Yorumlar",
    description: "Topluluk deneyimini kullanıcı yorumlarıyla görünür hale getir.",
  },
  {
    icon: Lock,
    title: "Gizlilik",
    description: "Telefon numaranı herkese göstermek zorunda değilsin. Konum yalnızca gerekli durumlarda kullanılır.",
  },
  {
    icon: Clock,
    title: "Hızlı geri dönüş",
    description: "Etkinlik başvuruları genelde kısa sürede yanıtlanır, uzun süre beklemezsin.",
  },
];

export function TrustSection() {
  return (
    <section aria-labelledby="trust-heading" className="mx-auto max-w-[1280px] px-6 py-16 md:py-24">
      <ScrollReveal>
        <h2 id="trust-heading" className="text-center text-3xl font-extrabold md:text-4xl" style={{ color: "var(--color-navy)" }}>
          Yeni insanlarla tanış. Güvenle.
        </h2>
      </ScrollReveal>

      <div className="mt-12 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-5">
        {ITEMS.map((it, i) => (
          <ScrollReveal key={it.title} delay={i * 0.06}>
            <div
              className="flex h-full flex-col items-start gap-3 rounded-2xl p-5"
              style={{ background: "var(--color-soft-navy)" }}
            >
              <span
                className="flex h-10 w-10 items-center justify-center rounded-full bg-white"
                style={{ boxShadow: "var(--shadow-sm)" }}
              >
                <it.icon size={18} color="var(--color-navy)" />
              </span>
              <h3 className="text-base font-bold" style={{ color: "var(--color-foreground)" }}>
                {it.title}
              </h3>
              <p className="text-sm" style={{ color: "var(--color-muted-foreground)" }}>
                {it.description}
              </p>
            </div>
          </ScrollReveal>
        ))}
      </div>
    </section>
  );
}
