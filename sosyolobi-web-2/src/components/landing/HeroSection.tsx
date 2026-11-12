"use client";

import Link from "next/link";
import { motion, useReducedMotion } from "framer-motion";
import { HeroMockup } from "./HeroMockup";

const EASE_OUT = [0.16, 1, 0.3, 1] as const;

const container = {
  hidden: {},
  show: { transition: { staggerChildren: 0.12 } },
};

export function HeroSection() {
  const reduceMotion = useReducedMotion();
  const item = {
    hidden: reduceMotion ? { opacity: 1 } : { opacity: 0, y: 16 },
    show: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE_OUT } },
  };

  return (
    <section className="mx-auto max-w-[1280px] px-6 py-12 md:py-20">
      <motion.div initial="hidden" animate="show" variants={container} className="hero-grid">
        <motion.div variants={item} className="hero-heading">
          <h1
            className="text-[42px] font-extrabold leading-[1.1] md:text-5xl lg:text-6xl"
            style={{ color: "var(--color-navy)" }}
          >
            Yapacak şey var.
            <br />
            İnsan yoksa{" "}
            <span style={{ color: "var(--color-accent-bright)" }}>Sosyolobi var.</span>
          </h1>
          <p className="mt-5 max-w-md text-lg" style={{ color: "var(--color-muted-foreground)" }}>
            Yapmak istediğin etkinliği oluştur, yakınındaki insanları bul ve birlikte
            gerçekleştirin.
          </p>
        </motion.div>

        <motion.div variants={item} className="hero-mockup">
          <HeroMockup />
        </motion.div>

        <motion.div variants={item} className="hero-cta flex flex-wrap items-start gap-4">
          <Link
            href="/app/map"
            className="w-full rounded-full px-7 py-3.5 text-center text-base font-bold text-white transition-transform hover:-translate-y-0.5 sm:w-auto"
            style={{ background: "var(--color-accent-bright)" }}
          >
            Etkinlikleri Keşfet →
          </Link>
          <a
            href="#nasil-calisir"
            className="w-full rounded-full border px-7 py-3.5 text-center text-base font-bold transition-colors hover:bg-black/[0.02] sm:w-auto"
            style={{ borderColor: "var(--color-border)", color: "var(--color-navy)" }}
          >
            Nasıl Çalışır?
          </a>
        </motion.div>
      </motion.div>
    </section>
  );
}
