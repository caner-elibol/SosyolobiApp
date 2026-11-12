import { Star } from "lucide-react";
import { ScrollReveal } from "./ScrollReveal";

const TESTIMONIALS = [
  { name: "Elif K.", city: "Kadıköy", text: "Tek başıma gitmek istemediğim etkinlikleri artık Sosyolobi'den insanlarla yapıyorum." },
  { name: "Mert Y.", city: "Beşiktaş", text: "Halı sahaya 2 kişi eksikti, 10 dakikada tamamladık. Harika bir sistem." },
  { name: "Zeynep A.", city: "Üsküdar", text: "Yeni şehre taşındım, ilk ayda Sosyolobi sayesinde yeni arkadaşlar edindim." },
  { name: "Can D.", city: "Beylikdüzü", text: "Konser biletim vardı ama kimse yoktu, uygulamadan tanıştığım biriyle gittik." },
  { name: "Selin T.", city: "Çekmeköy", text: "Akşam koşuları artık çok daha keyifli, hep birlikte koşuyoruz." },
  { name: "Barış Ö.", city: "Maltepe", text: "Doğa yürüyüşü grubunu buradan buldum, her hafta sonu buluşuyoruz." },
  { name: "Aslı G.", city: "Şişli", text: "Profil ve puan sistemi güven veriyor, kimlerle buluştuğumu biliyorum." },
  { name: "Kerem B.", city: "Ataşehir", text: "Masa tenisi için partner bulmak hiç bu kadar kolay olmamıştı." },
  { name: "Deniz U.", city: "Bakırköy", text: "Telefon doğrulama olması içimi rahatlattı, güvenle yeni insanlarla tanışıyorum." },
  { name: "Ece N.", city: "Sarıyer", text: "Hafta sonu kamp planı yapan bir grup buldum, unutulmaz bir deneyimdi." },
];

export function TestimonialsSection() {
  return (
    <section aria-labelledby="testimonials-heading" className="px-6 py-16 md:py-24" style={{ background: "var(--color-soft-navy)" }}>
      <div className="mx-auto max-w-[1280px]">
        <ScrollReveal>
          <h2 id="testimonials-heading" className="text-center text-3xl font-extrabold md:text-4xl" style={{ color: "var(--color-navy)" }}>
            Sosyolobi'de neler oluyor?
          </h2>
        </ScrollReveal>

        <div className="mt-12 grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {TESTIMONIALS.map((t, i) => (
            <ScrollReveal key={t.name} delay={(i % 3) * 0.06}>
              <div className="flex h-full flex-col gap-3 rounded-2xl border bg-white p-5" style={{ borderColor: "var(--color-border)" }}>
                <div className="flex gap-0.5" aria-hidden>
                  {Array.from({ length: 5 }).map((_, s) => (
                    <Star key={s} size={14} color="var(--color-accent-bright)" fill="var(--color-accent-bright)" />
                  ))}
                </div>
                <p className="text-sm" style={{ color: "var(--color-foreground)" }}>
                  "{t.text}"
                </p>
                <p className="mt-auto text-xs font-semibold" style={{ color: "var(--color-muted-foreground)" }}>
                  {t.name} · {t.city}
                </p>
              </div>
            </ScrollReveal>
          ))}
        </div>
      </div>
    </section>
  );
}
