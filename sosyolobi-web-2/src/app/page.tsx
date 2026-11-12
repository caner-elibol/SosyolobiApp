import type { Metadata } from "next";
import { LandingHeader } from "@/components/landing/LandingHeader";
import { HeroSection } from "@/components/landing/HeroSection";
import { HowItWorks } from "@/components/landing/HowItWorks";
import { MapDiscoverySection } from "@/components/landing/MapDiscoverySection";
import { ProblemSection } from "@/components/landing/ProblemSection";
import { TrustSection } from "@/components/landing/TrustSection";
import { CategoriesSection } from "@/components/landing/CategoriesSection";
import { TestimonialsSection } from "@/components/landing/TestimonialsSection";
import { FaqSection } from "@/components/landing/FaqSection";
import { FinalCta } from "@/components/landing/FinalCta";
import { LandingFooter } from "@/components/landing/LandingFooter";
import { StickyMobileCta } from "@/components/landing/StickyMobileCta";

export const metadata: Metadata = {
  title: "Sosyolobi — Etkinlik Keşfet, İnsanlarla Buluş",
  description:
    "Yapmak istediğin etkinliği oluştur, yakınındaki insanları bul ve birlikte gerçekleştirin. Sosyolobi ile yalnız plan yapma.",
  openGraph: {
    title: "Sosyolobi — İnsanlarla birlikte yaşa.",
    description: "Etkinlik oluştur, yakınındaki insanları bul, birlikte gerçekleştirin.",
    siteName: "Sosyolobi",
    locale: "tr_TR",
    type: "website",
    images: ["/opengraph-image"],
  },
  twitter: {
    card: "summary_large_image",
    title: "Sosyolobi",
    description: "Yapacak şey var. İnsan yoksa Sosyolobi var.",
  },
};

export default function Home() {
  return (
    <>
      <LandingHeader />
      <main>
        <HeroSection />
        <HowItWorks />
        <MapDiscoverySection />
        <ProblemSection />
        <TrustSection />
        <CategoriesSection />
        <TestimonialsSection />
        <FaqSection />
        <FinalCta />
      </main>
      <LandingFooter />
      <StickyMobileCta />
    </>
  );
}
