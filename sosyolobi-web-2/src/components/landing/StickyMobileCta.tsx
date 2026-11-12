"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { AnimatePresence, motion } from "framer-motion";

const EASE_OUT = [0.16, 1, 0.3, 1] as const;

export function StickyMobileCta() {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const heroHeight = window.innerHeight * 0.7;
    const onScroll = () => setVisible(window.scrollY > heroHeight);
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <AnimatePresence>
      {visible && (
        <motion.div
          initial={{ y: 80, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          exit={{ y: 80, opacity: 0 }}
          transition={{ duration: 0.25, ease: EASE_OUT }}
          className="fixed inset-x-0 bottom-0 z-40 border-t bg-white p-3 md:hidden"
          style={{ borderColor: "var(--color-border)", boxShadow: "var(--shadow-lg)" }}
        >
          <Link
            href="/app/map"
            className="block w-full rounded-full px-6 py-3 text-center text-sm font-bold text-white"
            style={{ background: "var(--color-accent-bright)" }}
          >
            Etkinlikleri Keşfet
          </Link>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
