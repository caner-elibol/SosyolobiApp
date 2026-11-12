import { readFileSync } from "node:fs";
import { join } from "node:path";
import { ImageResponse } from "next/og";

export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function OpengraphImage() {
  const logoBuffer = readFileSync(join(process.cwd(), "src/app/logo-white.png"));
  const logoSrc = `data:image/png;base64,${logoBuffer.toString("base64")}`;

  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          background: "#FFFFFF",
        }}
      >
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img src={logoSrc} width={520} height={293} alt="Sosyolobi" />
        <div style={{ display: "flex", fontSize: 30, color: "#667085", marginTop: 12 }}>
          İnsanlarla birlikte yaşa.
        </div>
        <div style={{ display: "flex", width: 200, height: 6, borderRadius: 3, background: "#FF9D23", marginTop: 28 }} />
      </div>
    ),
    { ...size }
  );
}
