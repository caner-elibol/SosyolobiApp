import Link from "next/link";
import { SosyolobiLogo } from "@/components/ui/SosyolobiLogo";

const COLUMNS = [
  {
    title: "Keşfet",
    links: [
      { label: "Etkinlikler", href: "/app/map" },
      { label: "Kategoriler", href: "#categories-heading" },
    ],
  },
  {
    title: "Sosyolobi",
    links: [{ label: "Nasıl Çalışır", href: "#nasil-calisir" }],
  },
];

export function LandingFooter() {
  return (
    <footer style={{ background: "var(--color-navy)" }} className="px-6 py-14 text-white">
      <div className="mx-auto grid max-w-[1280px] grid-cols-1 gap-10 md:grid-cols-[1.2fr_1fr_1fr_1fr]">
        <div>
          <SosyolobiLogo size="md" variant="white" animated={false} />
          <p className="mt-3 text-sm text-white/60">İnsanlarla birlikte yaşa.</p>
        </div>

        {COLUMNS.map((col) => (
          <div key={col.title}>
            <p className="text-sm font-bold text-white/80">{col.title}</p>
            <ul className="mt-3 flex flex-col gap-2">
              {col.links.map((link) => (
                <li key={link.label}>
                  <a href={link.href} className="text-sm text-white/60 transition-colors hover:text-white">
                    {link.label}
                  </a>
                </li>
              ))}
            </ul>
          </div>
        ))}

        <div>
          <p className="text-sm font-bold text-white/80">Destek</p>
          <ul className="mt-3 flex flex-col gap-2">
            <li className="text-sm text-white/60">İletişim</li>
            <li>
              <a href="#faq" className="text-sm text-white/60 transition-colors hover:text-white">
                SSS
              </a>
            </li>
          </ul>
        </div>
      </div>

      <div className="mx-auto mt-10 flex max-w-[1280px] flex-col gap-3 border-t border-white/10 pt-6 text-xs text-white/50 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex flex-wrap gap-4">
          <Link href="/gizlilik-politikasi" className="transition-colors hover:text-white">
            Gizlilik Politikası
          </Link>
          <span>Kullanım Koşulları</span>
        </div>
        <span>© 2026 Sosyolobi</span>
      </div>
    </footer>
  );
}
