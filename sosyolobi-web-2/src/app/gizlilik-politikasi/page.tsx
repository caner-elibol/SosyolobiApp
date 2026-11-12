import type { Metadata } from "next";
import Link from "next/link";
import Image from "next/image";
import logoWhite from "@/app/logo-white.png";

export const metadata: Metadata = {
  title: "Gizlilik Politikası — Sosyolobi",
  description: "Sosyolobi'nin konum, telefon numarası ve profil verilerini nasıl topladığı ve kullandığı.",
};

const SECTIONS = [
  {
    title: "1. Topladığımız Veriler",
    body: [
      "Telefon numarası: Hesabını doğrulamak ve güvenli bir topluluk oluşturmak için kullanılır.",
      "Konum bilgisi: Yakınındaki etkinlikleri gösterebilmek ve etkinlik oluştururken konum seçebilmen için kullanılır.",
      "Profil bilgileri: Ad, profil fotoğrafı ve ilgi alanların gibi kendi girdiğin bilgiler.",
      "Etkinlik ve etkileşim verileri: Katıldığın/oluşturduğun etkinlikler, aldığın puan ve yorumlar.",
    ],
  },
  {
    title: "2. Konum Verisini Nasıl Kullanıyoruz",
    body: [
      "Konumun yalnızca yakınındaki etkinlikleri sana göstermek ve senin oluşturduğun etkinliğin konumunu diğer kullanıcılara sunmak için kullanılır.",
      "Konumun sürekli olarak arka planda takip edilmez; yalnızca uygulamayı kullandığın sırada ve senin izninle alınır.",
      "Tam adresini herkese göstermek zorunda değilsin — etkinlik konumunu yaklaşık bir alan olarak paylaşabilirsin.",
    ],
  },
  {
    title: "3. Telefon Numaranın Gizliliği",
    body: [
      "Telefon numaran diğer kullanıcılara gösterilmez. Yalnızca hesap doğrulama ve güvenlik amacıyla saklanır.",
    ],
  },
  {
    title: "4. Verilerin Paylaşımı",
    body: [
      "Verilerin, yasal zorunluluklar dışında üçüncü taraflarla pazarlama amacıyla paylaşılmaz veya satılmaz.",
    ],
  },
  {
    title: "5. Verilerin Saklanması ve Güvenliği",
    body: [
      "Verilerin, yetkisiz erişime karşı korumak için makul teknik önlemlerle saklanır.",
      "Hesabını sildiğinde, kişisel verilerin ilgili yasal saklama süreleri dışında sistemden kaldırılır.",
    ],
  },
  {
    title: "6. Haklarınız",
    body: [
      "Verilerine erişme, düzeltme veya silinmesini talep etme hakkına sahipsin. Talepler için uygulama içi ayarlar veya destek kanallarını kullanabilirsin.",
    ],
  },
];

export default function PrivacyPolicyPage() {
  return (
    <main className="mx-auto max-w-3xl px-6 py-16">
      <Link href="/" aria-label="Sosyolobi anasayfa" className="flex items-center">
        <Image src={logoWhite} alt="Sosyolobi" style={{ height: 44, width: "auto" }} />
      </Link>

      <h1 className="mt-8 text-3xl font-extrabold" style={{ color: "var(--color-navy)" }}>
        Gizlilik Politikası
      </h1>
      <p className="mt-2 text-sm" style={{ color: "var(--color-muted-foreground)" }}>
        Son güncelleme: 2026
      </p>

      <div className="mt-10 flex flex-col gap-8">
        {SECTIONS.map((section) => (
          <section key={section.title}>
            <h2 className="text-lg font-bold" style={{ color: "var(--color-foreground)" }}>
              {section.title}
            </h2>
            <ul className="mt-3 flex flex-col gap-2">
              {section.body.map((line) => (
                <li key={line} className="text-sm leading-relaxed" style={{ color: "var(--color-muted-foreground)" }}>
                  {line}
                </li>
              ))}
            </ul>
          </section>
        ))}
      </div>
    </main>
  );
}
