"use client";

import { useState, useEffect, useRef, useCallback } from "react";
import { MoreHorizontal, type LucideIcon } from "lucide-react";

export interface ActionItem {
  label: string;
  icon?: LucideIcon;
  danger?: boolean;
  action: () => void;
}

interface ActionMenuProps {
  items: ActionItem[];
}

export function ActionMenu({ items }: ActionMenuProps) {
  const [open, setOpen] = useState(false);
  const [coords, setCoords] = useState({ top: 0, left: 0 });

  const btnRef = useRef<HTMLButtonElement>(null);
  const menuRef = useRef<HTMLDivElement>(null);

  const position = useCallback(() => {
    if (!btnRef.current) return;

    const r = btnRef.current.getBoundingClientRect();

    const MENU_WIDTH = 160;
    const GAP = 4;

    let left = r.right - MENU_WIDTH;

    if (left < 8) left = 8;

    if (left + MENU_WIDTH > window.innerWidth - 8) {
      left = window.innerWidth - MENU_WIDTH - 8;
    }

    setCoords({
      top: r.bottom + GAP,
      left,
    });
  }, []);

  function toggle(e: React.MouseEvent) {
    e.stopPropagation();

    if (!open) {
      position();
    }

    setOpen((v) => !v);
  }

  useEffect(() => {
    if (!open) return;

    function handleClick(e: MouseEvent) {
      const target = e.target as Node;

      if (
        menuRef.current?.contains(target) ||
        btnRef.current?.contains(target)
      ) {
        return;
      }

      setOpen(false);
    }

    function handleScroll() {
      setOpen(false);
    }

    window.addEventListener("click", handleClick);
    window.addEventListener("resize", position);
    document.addEventListener("scroll", handleScroll, true);

    return () => {
      window.removeEventListener("click", handleClick);
      window.removeEventListener("resize", position);
      document.removeEventListener("scroll", handleScroll, true);
    };
  }, [open, position]);

  return (
    <>
      <button
        ref={btnRef}
        type="button"
        onClick={toggle}
        style={{
          width: 30,
          height: 30,
          borderRadius: 8,
          border: "1px solid #F0F1F5",
          backgroundColor: "#fff",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          cursor: "pointer",
          color: "#6B7280",
        }}
        onMouseEnter={(e) => {
          e.currentTarget.style.backgroundColor = "#F8F9FF";
        }}
        onMouseLeave={(e) => {
          e.currentTarget.style.backgroundColor = "#fff";
        }}
      >
        <MoreHorizontal size={15} />
      </button>

      {open && (
        <div
          ref={menuRef}
          onClick={(e) => e.stopPropagation()}
          style={{
            position: "fixed",
            top: coords.top,
            left: coords.left,
            width: 160,
            zIndex: 9999,

            backgroundColor: "#fff",
            borderRadius: 12,

            border: "1px solid #F0F1F5",

            boxShadow: "0 8px 32px rgba(0,0,0,0.12)",

            overflow: "hidden",
          }}
        >
          {items.map(({ label, icon: Icon, action, danger }) => (
            <button
              key={label}
              type="button"
              onClick={(e) => {
                e.stopPropagation();

                action();

                setOpen(false);
              }}
              style={{
                width: "100%",

                padding: "10px 14px",

                border: "none",

                backgroundColor: "transparent",

                textAlign: "left",

                fontSize: 13,

                cursor: "pointer",

                color: danger ? "#B91C1C" : "#1B1D29",

                display: "flex",

                alignItems: "center",

                gap: 8,
              }}
              onMouseEnter={(e) => {
                e.currentTarget.style.backgroundColor = "#F8F9FF";
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.backgroundColor = "transparent";
              }}
            >
              {Icon && <Icon size={14} />}

              {label}
            </button>
          ))}
        </div>
      )}
    </>
  );
}