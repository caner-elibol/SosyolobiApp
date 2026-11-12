import Link from "next/link";
import { ScrollReveal } from "./ScrollReveal";

export function FinalCta() {
  return (
    <section
      aria-labelledby="final-cta-heading"
      className="px-6 py-16 md:py-24"
      style={{ background: "var(--color-soft-orange)" }}
    >
      <ScrollReveal>
        <div className="mx-auto max-w-xl text-center">
          <h2 id="final-cta-heading" className="text-3xl font-extrabold md:text-4xl" style={{ color: "var(--color-navy)" }}>
            Tek başına plan yapma.
          </h2>
          <p className="mt-4 text-lg" style={{ color: "var(--color-muted-foreground)" }}>
            Yapmak istediğin şey için doğru insanları bul.
          </p>
          <div className="mt-8 flex flex-wrap justify-center gap-4">
            <Link
              href="/app/map"
              className="w-full rounded-full px-7 py-3.5 text-center text-base font-bold text-white transition-transform hover:-translate-y-0.5 sm:w-auto"
              style={{ background: "var(--color-accent-bright)" }}
            >
              Etkinlikleri Keşfet
            </Link>
            <Link
              href="/app/activities/create"
              className="w-full rounded-full border px-7 py-3.5 text-center text-base font-bold transition-colors hover:bg-black/[0.02] sm:w-auto"
              style={{ borderColor: "var(--color-navy)", color: "var(--color-navy)" }}
            >
              Etkinlik Oluştur
            </Link>
          </div>
        </div>
      </ScrollReveal>
    </section>
  );
}
