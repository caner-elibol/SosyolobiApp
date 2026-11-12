"use client";

import { useRef, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";

interface BottomSheetProps {
  open: boolean;
  onClose?: () => void;
  children: React.ReactNode;
  title?: string;
  snapHeight?: number | string;
}

export function BottomSheet({ open, onClose, children, title, snapHeight = "60vh" }: BottomSheetProps) {
  return (
    <AnimatePresence>
      {open && (
        <>
          {onClose && (
            <motion.div
              key="overlay"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              onClick={onClose}
              style={{
                position: "fixed",
                inset: 0,
                background: "rgba(0,0,0,0.3)",
                zIndex: 300,
              }}
            />
          )}
          <motion.div
            key="sheet"
            initial={{ y: "100%" }}
            animate={{ y: 0 }}
            exit={{ y: "100%" }}
            transition={{ type: "spring", damping: 30, stiffness: 300 }}
            style={{
              position: "fixed",
              bottom: 0,
              left: 0,
              right: 0,
              background: "var(--color-surface)",
              borderRadius: "20px 20px 0 0",
              zIndex: 301,
              maxHeight: snapHeight,
              overflow: "hidden",
              display: "flex",
              flexDirection: "column",
            }}
          >
            <div style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              padding: "12px 20px 8px",
              flexShrink: 0,
            }}>
              <div style={{ width: 36, height: 4, background: "#D1D5DB", borderRadius: "var(--radius-full)" }} />
            </div>
            {title && (
              <div style={{ padding: "0 20px 12px", flexShrink: 0 }}>
                <h3 style={{ fontSize: 16, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>{title}</h3>
              </div>
            )}
            <div style={{ overflowY: "auto", flex: 1, padding: "0 16px 80px" }}>
              {children}
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
