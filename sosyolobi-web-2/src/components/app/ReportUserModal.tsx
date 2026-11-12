"use client";

import { useState } from "react";
import { toast } from "sonner";
import { useReportUser } from "@/hooks/useUserActions";

const REASONS = [
  "Uygunsuz davranış",
  "Taciz veya tehdit",
  "Sahte profil",
  "Spam",
  "Diğer",
];

interface ReportUserModalProps {
  userId: string;
  displayName: string;
  onClose: () => void;
}

export function ReportUserModal({ userId, displayName, onClose }: ReportUserModalProps) {
  const [reason, setReason] = useState(REASONS[0]);
  const [details, setDetails] = useState("");
  const report = useReportUser();

  async function handleSubmit() {
    try {
      await report.mutateAsync({ reportedUserId: userId, reason, details: details || undefined });
      toast.success("Şikayetiniz alındı.");
      onClose();
    } catch {
      toast.error("Şikayet gönderilemedi.");
    }
  }

  return (
    <div
      style={{
        position: "fixed",
        inset: 0,
        background: "rgba(0,0,0,0.4)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 400,
        padding: 16,
      }}
      onClick={onClose}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        style={{
          background: "var(--color-surface)",
          borderRadius: "var(--radius-lg)",
          padding: 24,
          width: "100%",
          maxWidth: 380,
        }}
      >
        <h3 style={{ fontSize: 16, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 4px" }}>
          {displayName} kullanıcısını şikayet et
        </h3>
        <p style={{ fontSize: 13, color: "var(--color-muted-foreground)", margin: "0 0 16px" }}>
          Şikayetiniz ekibimiz tarafından incelenecektir.
        </p>

        <label style={{ fontSize: 13, fontWeight: 500, color: "#374151", display: "block", marginBottom: 6 }}>
          Sebep
        </label>
        <select
          value={reason}
          onChange={(e) => setReason(e.target.value)}
          style={{
            width: "100%",
            padding: "10px 12px",
            border: "1px solid var(--color-border)",
            borderRadius: "var(--radius-sm)",
            fontSize: 14,
            marginBottom: 14,
            boxSizing: "border-box",
            fontFamily: "inherit",
          }}
        >
          {REASONS.map((r) => <option key={r} value={r}>{r}</option>)}
        </select>

        <label style={{ fontSize: 13, fontWeight: 500, color: "#374151", display: "block", marginBottom: 6 }}>
          Detay (opsiyonel)
        </label>
        <textarea
          value={details}
          onChange={(e) => setDetails(e.target.value)}
          rows={3}
          placeholder="Yaşadığınız durumu kısaca açıklayın..."
          style={{
            width: "100%",
            padding: "10px 12px",
            border: "1px solid var(--color-border)",
            borderRadius: "var(--radius-sm)",
            fontSize: 14,
            resize: "vertical",
            boxSizing: "border-box",
            marginBottom: 18,
            fontFamily: "inherit",
          }}
        />

        <div style={{ display: "flex", gap: 8 }}>
          <button
            onClick={onClose}
            style={{
              flex: 1,
              padding: "12px",
              background: "none",
              border: "1px solid var(--color-border)",
              borderRadius: "var(--radius-md)",
              fontSize: 14,
              color: "var(--color-muted-foreground)",
              cursor: "pointer",
            }}
          >
            İptal
          </button>
          <button
            onClick={handleSubmit}
            disabled={report.isPending}
            style={{
              flex: 1,
              padding: "12px",
              background: "var(--color-destructive)",
              color: "#fff",
              border: "none",
              borderRadius: "var(--radius-md)",
              fontSize: 14,
              fontWeight: 600,
              cursor: "pointer",
              opacity: report.isPending ? 0.7 : 1,
            }}
          >
            {report.isPending ? "Gönderiliyor..." : "Şikayet Et"}
          </button>
        </div>
      </div>
    </div>
  );
}
