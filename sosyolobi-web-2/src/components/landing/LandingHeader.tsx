"use client";

import { useState } from "react";
import Link from "next/link";
import Image from "next/image";
import { Menu, X } from "lucide-react";
import { AnimatePresence, motion } from "framer-motion";
import logoWhite from "@/app/logo-white.png";

const EASE_OUT = [0.16, 1, 0.3, 1] as const;

const NAV_LINKS = [
  { label: "Nasıl Çalışır", href: "#nasil-calisir" },
  { label: "Etkinlikler", href: "/app/map" },
];

export function LandingHeader() {
  const [open, setOpen] = useState(false);

  return (
    <header
      className="sticky top-0 z-50 border-b"
      style={{
        background: "rgba(255,255,255,0.9)",
        backdropFilter: "blur(8px)",
        borderColor: "var(--color-border)",
      }}
    >
      <div className="mx-auto flex h-20 max-w-[1280px] items-center justify-between px-6">
        <Link href="/" aria-label="Sosyolobi anasayfa" className="flex items-center">
          <Image src={logoWhite} alt="Sosyolobi" priority style={{ height: 68, width: "auto" }} />
        </Link>

        <nav aria-label="Ana menü" className="hidden items-center gap-8 md:flex">
          {NAV_LINKS.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="text-sm font-semibold transition-colors hover:opacity-70"
              style={{ color: "var(--color-foreground)" }}
            >
              {link.label}
            </a>
          ))}
        </nav>

        <div className="hidden items-center gap-3 md:flex">
          <Link
            href="/auth/login"
            className="text-sm font-semibold transition-colors hover:opacity-70"
            style={{ color: "var(--color-foreground)" }}
          >
            Giriş Yap
          </Link>
          <Link
            href="/auth/login"
            className="rounded-full px-5 py-2.5 text-sm font-bold text-white transition-transform hover:-translate-y-0.5"
            style={{ background: "var(--color-accent-bright)" }}
          >
            Kayıt Ol
          </Link>
        </div>

        <button
          type="button"
          className="md:hidden"
          aria-label={open ? "Menüyü kapat" : "Menüyü aç"}
          aria-expanded={open}
          onClick={() => setOpen((v) => !v)}
        >
          {open ? <X size={24} /> : <Menu size={24} />}
        </button>
      </div>

      <AnimatePresence>
        {open && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.2, ease: EASE_OUT }}
            className="overflow-hidden border-t md:hidden"
            style={{ borderColor: "var(--color-border)", background: "#fff" }}
          >
            <nav aria-label="Mobil menü" className="flex flex-col gap-1 px-6 py-4">
              {NAV_LINKS.map((link) => (
                <a
                  key={link.href}
                  href={link.href}
                  onClick={() => setOpen(false)}
                  className="py-2 text-sm font-semibold"
                  style={{ color: "var(--color-foreground)" }}
                >
                  {link.label}
                </a>
              ))}
              <Link
                href="/auth/login"
                onClick={() => setOpen(false)}
                className="py-2 text-sm font-semibold"
                style={{ color: "var(--color-foreground)" }}
              >
                Giriş Yap
              </Link>
              <Link
                href="/auth/login"
                onClick={() => setOpen(false)}
                className="mt-2 rounded-full px-5 py-3 text-center text-sm font-bold text-white"
                style={{ background: "var(--color-accent-bright)" }}
              >
                Kayıt Ol
              </Link>
            </nav>
          </motion.div>
        )}
      </AnimatePresence>
    </header>
  );
}
