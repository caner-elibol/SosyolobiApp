import type { MapLibreEvent, MapStyleImageMissingEvent } from "maplibre-gl";

export function silenceMissingStyleImages(e: MapLibreEvent) {
  e.target.on("styleimagemissing", (ev: MapStyleImageMissingEvent) => {
    const map = ev.target;
    if (map.hasImage(ev.id)) return;
    map.addImage(ev.id, { width: 1, height: 1, data: new Uint8Array(4) });
  });
}
