import Link from "next/link";
import Image from "next/image";
import logoWhite from "@/app/logo-white.png";

export default function NotFound() {
  return (
    <main
      className="flex min-h-dvh flex-col items-center justify-center gap-6 px-6 text-center"
      style={{ background: "#FFFFFF" }}
    >
      <Image src={logoWhite} alt="Sosyolobi" priority style={{ height: 72, width: "auto" }} />
      <div>
        <h1 className="text-2xl font-extrabold" style={{ color: "var(--color-navy)" }}>
          Bu sayfa bulunamadı
        </h1>
        <p className="mt-2 text-sm" style={{ color: "var(--color-muted-foreground)" }}>
          Aradığın sayfa taşınmış veya hiç var olmamış olabilir.
        </p>
      </div>
      <div className="flex flex-wrap justify-center gap-4">
        <Link
          href="/"
          className="rounded-full px-6 py-3 text-sm font-bold text-white"
          style={{ background: "var(--color-accent-bright)" }}
        >
          Anasayfaya Dön
        </Link>
        <Link
          href="/app/map"
          className="rounded-full border px-6 py-3 text-sm font-bold"
          style={{ borderColor: "var(--color-border)", color: "var(--color-navy)" }}
        >
          Etkinlikleri Keşfet
        </Link>
      </div>
    </main>
  );
}
