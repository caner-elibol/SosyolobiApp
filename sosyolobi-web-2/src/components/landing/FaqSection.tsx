import { ScrollReveal } from "./ScrollReveal";

const FAQS = [
  {
    question: "Sosyolobi ücretsiz mi?",
    answer: "Evet, Sosyolobi'yi kullanmak, etkinlik keşfetmek ve oluşturmak ücretsizdir.",
  },
  {
    question: "Telefon numaram başkalarına görünür mü?",
    answer: "Hayır. Telefon numaran yalnızca doğrulama için kullanılır, diğer kullanıcılara gösterilmez.",
  },
  {
    question: "Etkinlik nasıl oluşturulur?",
    answer: "\"Etkinlik Oluştur\" butonuna tıkla, kategori/tarih/konum bilgilerini gir ve etkinliğini yayınla.",
  },
  {
    question: "Katılım başvurum nasıl onaylanıyor?",
    answer: "Bir etkinliğe başvurduğunda, etkinlik sahibi başvurunu inceleyip onaylar veya reddeder.",
  },
  {
    question: "Sosyolobi hangi şehirlerde kullanılabilir?",
    answer: "Konum tabanlı çalıştığı için bulunduğun her yerde etkinlik keşfedebilir veya oluşturabilirsin.",
  },
];

export function FaqSection() {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: FAQS.map((f) => ({
      "@type": "Question",
      name: f.question,
      acceptedAnswer: { "@type": "Answer", text: f.answer },
    })),
  };

  return (
    <section id="faq" aria-labelledby="faq-heading" className="mx-auto max-w-[1280px] px-6 py-16 md:py-24">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <ScrollReveal>
        <h2 id="faq-heading" className="text-center text-3xl font-extrabold md:text-4xl" style={{ color: "var(--color-navy)" }}>
          Sıkça Sorulan Sorular
        </h2>
      </ScrollReveal>

      <div className="mx-auto mt-10 flex max-w-2xl flex-col gap-4">
        {FAQS.map((faq, i) => (
          <ScrollReveal key={faq.question} delay={i * 0.05}>
            <div className="rounded-2xl border p-5" style={{ borderColor: "var(--color-border)" }}>
              <h3 className="text-base font-bold" style={{ color: "var(--color-foreground)" }}>
                {faq.question}
              </h3>
              <p className="mt-2 text-sm" style={{ color: "var(--color-muted-foreground)" }}>
                {faq.answer}
              </p>
            </div>
          </ScrollReveal>
        ))}
      </div>
    </section>
  );
}
