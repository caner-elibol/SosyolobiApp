"use client";

import { useState, useCallback, useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { useQuery } from "@tanstack/react-query";
import Map, { Marker } from "react-map-gl/maplibre";
import "maplibre-gl/dist/maplibre-gl.css";
import { toast } from "sonner";
import { useRouter } from "next/navigation";
import { userApiClient } from "@/lib/user-api-client";
import { silenceMissingStyleImages } from "@/lib/map-utils";
import { useCreateActivity } from "@/hooks/useCreateActivity";
import { useCurrentLocation } from "@/hooks/useCurrentLocation";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";
import { SkillLevel, GenderPreference } from "@/types/user";
import type { Category } from "@/types/user";
import { ArrowLeft, ArrowRight, CalendarDays, Check, Clock, MapPin, Sparkles } from "lucide-react";

const schema = z.object({
  categoryId: z.string().min(1, "Kategori seçin"),
  title: z.string().min(3, "Başlık en az 3 karakter"),
  description: z.string().optional(),
  eventDate: z.string().min(1, "Tarih seçin"),
  neededPeopleCount: z.number().min(1, "En az 1 kişi"),
  pricePerPerson: z.number().min(0, "0 veya üzeri olmalı"),
  skillLevel: z.number(),
  genderPreference: z.number(),
  addressText: z.string().min(5, "Adres açıklaması zorunlu"),
  addressDetailPrivate: z.string().optional(),
});
type FormValues = z.infer<typeof schema>;

const STEP_LABELS = ["Kategori Seç", "Etkinlik Detayları", "Konum ve Katılımcılar"];

function nowForDatetimeLocal() {
  const d = new Date(Date.now() - new Date().getTimezoneOffset() * 60000);
  return d.toISOString().slice(0, 16);
}

export function CreateActivityForm() {
  const router = useRouter();
  const create = useCreateActivity();
  const [step, setStep] = useState(1);
  const [pin, setPin] = useState<{ lat: number; lng: number } | null>(null);
  const { location, permission, request: requestLocation } = useCurrentLocation();
  const nowLocal = nowForDatetimeLocal();
  const [dateStr, setDateStr] = useState(nowLocal.slice(0, 10));
  const [timeStr, setTimeStr] = useState(nowLocal.slice(11, 16));

  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: () => userApiClient<Category[]>("/api/categories"),
    staleTime: Infinity,
  });

  const { register, handleSubmit, setValue, watch, trigger, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
    defaultValues: {
      categoryId: "",
      skillLevel: SkillLevel.Any,
      genderPreference: GenderPreference.Any,
      neededPeopleCount: 1,
      pricePerPerson: 0,
      eventDate: nowLocal,
    },
  });

  useEffect(() => {
    setValue("eventDate", `${dateStr}T${timeStr}`, { shouldValidate: true });
  }, [dateStr, timeStr, setValue]);

  const handleMapClick = useCallback((evt: { lngLat: { lat: number; lng: number } }) => {
    setPin({ lat: evt.lngLat.lat, lng: evt.lngLat.lng });
  }, []);

  useEffect(() => {
    if (location && pin === null) {
      setPin(location);
    }
  }, [location, pin]);

  useEffect(() => {
    if (step === 3 && permission === "prompt") {
      requestLocation();
    }
  }, [step, permission, requestLocation]);

  const categoryId = watch("categoryId");

  async function goNext() {
    const fieldsByStep: Record<number, (keyof FormValues)[]> = {
      1: ["categoryId"],
      2: ["title", "eventDate", "neededPeopleCount"],
    };
    const ok = await trigger(fieldsByStep[step]);
    if (ok) setStep((s) => s + 1);
  }

  function goBack() {
    if (step === 1) { router.push("/app/activities"); return; }
    setStep((s) => s - 1);
  }

  async function onSubmit(values: FormValues) {
    if (!pin) { toast.error("Haritadan bir konum seçin."); return; }
    try {
      const activity = await create.mutateAsync({
        ...values,
        latitude: pin.lat,
        longitude: pin.lng,
        eventDate: new Date(values.eventDate).toISOString(),
      });
      toast.success("Etkinlik oluşturuldu!");
      router.push(`/app/activities/${activity.id}`);
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "Etkinlik oluşturulamadı.");
    }
  }

  const stepHelper = [
    "Devam etmek için kategori seçin.",
    "Devam etmek için başlık ve tarih girin.",
    "Konum seçip etkinliği oluşturun.",
  ][step - 1];

  return (
    <div style={{ background: "var(--color-surface)", borderRadius: "var(--radius-xl)", border: "1px solid var(--color-border)", overflow: "hidden" }}>
      <div style={{
        padding: "18px 24px",
        borderBottom: "1px solid var(--color-border)",
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        flexWrap: "wrap",
        gap: 16,
      }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <button type="button" onClick={goBack} style={{
            width: 32, height: 32, borderRadius: "50%", border: "1px solid var(--color-border)",
            background: "var(--color-surface)", display: "flex", alignItems: "center", justifyContent: "center", cursor: "pointer",
          }}>
            <ArrowLeft size={16} color="var(--color-foreground)" />
          </button>
          <h1 style={{ fontSize: 18, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>Etkinlik Oluştur</h1>
        </div>
        <StepIndicator step={step} />
      </div>

      <form onSubmit={handleSubmit(onSubmit)}>
        <div className="wizard-body" style={{ display: "flex", gap: 24, flexWrap: "wrap" }}>
          <div style={{ flex: 1, minWidth: 0 }}>
            {step === 1 && (
              <CategoryStep
                categories={categories}
                value={categoryId}
                onSelect={(id) => setValue("categoryId", id, { shouldValidate: true })}
                error={errors.categoryId?.message}
              />
            )}

            {step === 2 && (
              <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
                <Field label="Etkinlik Başlığı" error={errors.title?.message}>
                  <input {...register("title")} placeholder="Örn. Dağ Yürüyüşü" style={inputStyle} />
                </Field>
                <Field label="Açıklama (opsiyonel)">
                  <textarea {...register("description")} rows={3} placeholder="Etkinliğiniz hakkında bilgi verin..." style={{ ...inputStyle, resize: "vertical" }} />
                </Field>
                <div style={{ display: "flex", gap: 12 }}>
                  <Field label="Tarih" error={errors.eventDate?.message} style={{ flex: 1 }}>
                    <div style={{ position: "relative" }}>
                      <CalendarDays size={15} color="var(--color-muted-foreground)" style={{ position: "absolute", left: 12, top: "50%", transform: "translateY(-50%)" }} />
                      <input type="date" value={dateStr} onChange={(e) => setDateStr(e.target.value)} style={{ ...inputStyle, paddingLeft: 36 }} />
                    </div>
                  </Field>
                  <Field label="Saat" style={{ flex: 1 }}>
                    <div style={{ position: "relative" }}>
                      <Clock size={15} color="var(--color-muted-foreground)" style={{ position: "absolute", left: 12, top: "50%", transform: "translateY(-50%)" }} />
                      <input type="time" value={timeStr} onChange={(e) => setTimeStr(e.target.value)} style={{ ...inputStyle, paddingLeft: 36 }} />
                    </div>
                  </Field>
                </div>
                <div style={{ display: "flex", gap: 12 }}>
                  <Field label="Kaç kişi katılabilir?" error={errors.neededPeopleCount?.message} style={{ flex: 1 }}>
                    <input {...register("neededPeopleCount", { valueAsNumber: true })} type="number" min={1} style={inputStyle} />
                  </Field>
                  <Field label="Kişi Başı Ücret" error={errors.pricePerPerson?.message} style={{ flex: 1 }}>
                    <input
                      {...register("pricePerPerson", { setValueAs: (v) => (v === "" || v === null ? 0 : Number(v)) })}
                      type="number"
                      min={0}
                      placeholder="0 ₺"
                      style={inputStyle}
                    />
                  </Field>
                </div>
                <Field label="Seviye">
                  <select {...register("skillLevel", { valueAsNumber: true })} style={inputStyle}>
                    <option value={0}>Herkes</option>
                    <option value={1}>Başlangıç</option>
                    <option value={2}>Orta</option>
                    <option value={3}>İleri</option>
                  </select>
                </Field>
              </div>
            )}

            {step === 3 && (
              <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
                <Field label="Haritadan Seç" error={pin ? undefined : "Konum zorunlu"}>
                  <div style={{ height: 280, borderRadius: "var(--radius-md)", overflow: "hidden", border: "1px solid var(--color-border)" }}>
                    {permission === "loading" ? (
                      <div style={{
                        width: "100%", height: "100%", display: "flex", alignItems: "center", justifyContent: "center",
                        background: "var(--color-background)", color: "var(--color-muted-foreground)", fontSize: 13,
                      }}>
                        Konum alınıyor...
                      </div>
                    ) : (
                      <Map
                        reuseMaps
                        onLoad={silenceMissingStyleImages}
                        initialViewState={{
                          longitude: (location ?? { lat: 41.0082, lng: 28.9784 }).lng,
                          latitude: (location ?? { lat: 41.0082, lng: 28.9784 }).lat,
                          zoom: 12,
                        }}
                        mapStyle="https://tiles.openfreemap.org/styles/liberty"
                        style={{ width: "100%", height: "100%" }}
                        onClick={handleMapClick}
                        cursor="crosshair"
                      >
                        {pin && (
                          <Marker longitude={pin.lng} latitude={pin.lat} anchor="bottom">
                            <MapPin size={28} color="var(--color-accent)" fill="var(--color-accent-soft-bg)" strokeWidth={2} />
                          </Marker>
                        )}
                      </Map>
                    )}
                  </div>
                  {pin && (
                    <p style={{ fontSize: 12, color: "var(--color-muted-foreground)", marginTop: 4 }}>
                      Konum belirlendi: {pin.lat.toFixed(5)}, {pin.lng.toFixed(5)} — haritada başka bir yere tıklayarak değiştirebilirsiniz.
                    </p>
                  )}
                </Field>
                <Field label="Konum Adı" error={errors.addressText?.message}>
                  <input {...register("addressText")} placeholder="Örn. Çekmeköy Spor Kompleksi" style={inputStyle} />
                </Field>
                <Field label="Gizli Adres Detayı (onaylı katılımcılara gösterilir)">
                  <input {...register("addressDetailPrivate")} placeholder="Kapı numarası, detaylı adres..." style={inputStyle} />
                </Field>
                <Field label="Kimler Katılabilir?">
                  <select {...register("genderPreference", { valueAsNumber: true })} style={inputStyle}>
                    <option value={0}>Herkes</option>
                    <option value={1}>Erkek</option>
                    <option value={2}>Kadın</option>
                    <option value={3}>Karışık</option>
                  </select>
                </Field>
              </div>
            )}
          </div>

          {step === 1 && <TipCard />}
        </div>

        <div style={{
          padding: "16px 24px",
          borderTop: "1px solid var(--color-border)",
          display: "flex",
          alignItems: "center",
          justifyContent: "space-between",
          flexWrap: "wrap",
          gap: 12,
          background: "#FAFBFD",
        }}>
          <div>
            <p style={{ fontSize: 13, fontWeight: 600, color: "var(--color-foreground)", margin: 0 }}>Adım {step} / 3</p>
            <p style={{ fontSize: 12, color: "var(--color-muted-foreground)", margin: "2px 0 0" }}>{stepHelper}</p>
          </div>
          <div style={{ display: "flex", gap: 10 }}>
            <button type="button" onClick={goBack} style={{
              padding: "10px 18px",
              borderRadius: "var(--radius-md)",
              border: "1px solid var(--color-border)",
              background: "var(--color-surface)",
              color: "var(--color-foreground)",
              fontSize: 14,
              fontWeight: 600,
              cursor: "pointer",
            }}>
              {step === 1 ? "İptal" : "Geri"}
            </button>
            {step < 3 ? (
              <button type="button" onClick={goNext} style={{
                display: "inline-flex", alignItems: "center", gap: 6,
                padding: "10px 20px",
                borderRadius: "var(--radius-md)",
                border: "none",
                background: "var(--color-accent-bright)",
                color: "#fff",
                fontSize: 14,
                fontWeight: 700,
                cursor: "pointer",
              }}>
                Devam Et <ArrowRight size={15} />
              </button>
            ) : (
              <button type="submit" disabled={isSubmitting || create.isPending} style={{
                padding: "10px 20px",
                borderRadius: "var(--radius-md)",
                border: "none",
                background: "var(--color-accent-bright)",
                color: "#fff",
                fontSize: 14,
                fontWeight: 700,
                cursor: "pointer",
                opacity: isSubmitting || create.isPending ? 0.7 : 1,
              }}>
                {isSubmitting || create.isPending ? "Oluşturuluyor..." : "Etkinliği Oluştur"}
              </button>
            )}
          </div>
        </div>
      </form>

      <style>{`
        .wizard-body { padding: 16px; }
        .category-grid {
          display: grid;
          grid-template-columns: repeat(4, 1fr);
          gap: 8px;
        }
        .category-card { padding: 10px 4px; gap: 6px; }
        .category-card-icon { width: 30px; height: 30px; }
        .category-card-label { font-size: 10.5px; }
        @media (min-width: 480px) {
          .category-grid { grid-template-columns: repeat(auto-fill, minmax(110px, 1fr)); gap: 10px; }
          .category-card { padding: 16px 8px; gap: 8px; }
          .category-card-icon { width: 38px; height: 38px; }
          .category-card-label { font-size: 12px; }
        }
        @media (min-width: 768px) {
          .wizard-body { padding: 24px; }
          .category-grid { grid-template-columns: repeat(auto-fill, minmax(130px, 1fr)); gap: 12px; }
          .category-card { padding: 20px 10px; gap: 10px; }
          .category-card-icon { width: 44px; height: 44px; }
          .category-card-label { font-size: 13px; }
        }
      `}</style>
    </div>
  );
}

function StepIndicator({ step }: { step: number }) {
  return (
    <div style={{ display: "flex", alignItems: "center" }}>
      {STEP_LABELS.map((label, i) => {
        const n = i + 1;
        const reached = n <= step;
        return (
          <div key={n} style={{ display: "flex", alignItems: "center" }}>
            {i > 0 && (
              <div style={{ width: 32, height: 2, background: reached ? "var(--color-accent-bright)" : "var(--color-border)", margin: "0 8px" }} />
            )}
            <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
              <span style={{
                width: 26,
                height: 26,
                borderRadius: "50%",
                background: reached ? "var(--color-accent-bright)" : "var(--color-border)",
                color: reached ? "#fff" : "var(--color-muted-foreground)",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: 12,
                fontWeight: 700,
                flexShrink: 0,
              }}>
                {n}
              </span>
              <span className="hidden-mobile" style={{
                fontSize: 13,
                fontWeight: n === step ? 700 : 500,
                color: reached ? "var(--color-foreground)" : "var(--color-muted-foreground)",
                whiteSpace: "nowrap",
              }}>
                {label}
              </span>
            </div>
          </div>
        );
      })}
    </div>
  );
}

function TipCard() {
  return (
    <div className="hidden-mobile" style={{
      width: 240,
      flexShrink: 0,
      background: "var(--color-accent-soft-bg)",
      borderRadius: "var(--radius-lg)",
      padding: 20,
      alignSelf: "flex-start",
    }}>
      <div style={{ display: "flex", alignItems: "center", gap: 6, marginBottom: 8 }}>
        <Sparkles size={15} color="var(--color-accent)" />
        <span style={{ fontSize: 13, fontWeight: 700, color: "var(--color-accent-soft-fg)" }}>İpucu</span>
      </div>
      <p style={{ fontSize: 13, color: "var(--color-accent-soft-fg)", lineHeight: 1.5, margin: 0 }}>
        Doğru kategori seçmek, etkinliğinizi ilgili kişilere ulaştırmamıza yardımcı olur.
      </p>
    </div>
  );
}

function CategoryStep({ categories, value, onSelect, error }: {
  categories: Category[];
  value: string;
  onSelect: (id: string) => void;
  error?: string;
}) {
  return (
    <div>
      <h2 style={{ fontSize: 17, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 4px" }}>
        Etkinliğinizi hangi kategoriye ait?
      </h2>
      <p style={{ fontSize: 13, color: "var(--color-muted-foreground)", margin: "0 0 20px" }}>
        Etkinliğinizin temasını en iyi yansıtan kategoriyi seçin.
      </p>
      <div className="category-grid">
        {categories.map((c) => {
          const Icon = getCategoryIcon(c.name);
          const color = getCategoryColor(c.name, c.color);
          const active = value === c.id;
          return (
            <button
              key={c.id}
              type="button"
              onClick={() => onSelect(c.id)}
              className="category-card"
              style={{
                position: "relative",
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
                borderRadius: "var(--radius-lg)",
                border: active ? "1.5px solid var(--color-accent-bright)" : "1px solid var(--color-border)",
                background: active ? "var(--color-accent-soft-bg)" : "var(--color-surface)",
                cursor: "pointer",
                transition: "border-color 0.15s ease, background 0.15s ease",
                minWidth: 0,
              }}
            >
              {active && (
                <span style={{
                  position: "absolute", top: 6, right: 6,
                  width: 16, height: 16, borderRadius: "50%",
                  background: "var(--color-accent-bright)",
                  display: "flex", alignItems: "center", justifyContent: "center",
                }}>
                  <Check size={10} color="#fff" strokeWidth={3} />
                </span>
              )}
              <span className="category-card-icon" style={{
                borderRadius: "50%",
                background: `color-mix(in srgb, ${color} 16%, white)`,
                display: "flex", alignItems: "center", justifyContent: "center",
                flexShrink: 0,
              }}>
                <Icon size={18} color={color} strokeWidth={2} />
              </span>
              <span className="category-card-label" style={{ fontWeight: 600, color: "var(--color-foreground)", textAlign: "center", overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap", maxWidth: "100%" }}>
                {c.name}
              </span>
            </button>
          );
        })}
      </div>
      {error && <p style={{ fontSize: 12, color: "var(--color-destructive)", marginTop: 12 }}>{error}</p>}
    </div>
  );
}

const inputStyle: React.CSSProperties = {
  width: "100%",
  padding: "11px 14px",
  border: "1px solid var(--color-border)",
  borderRadius: "var(--radius-sm)",
  fontSize: 14,
  outline: "none",
  background: "var(--color-surface)",
  boxSizing: "border-box",
  fontFamily: "inherit",
};

function Field({ label, error, children, style }: {
  label: string;
  error?: string;
  children: React.ReactNode;
  style?: React.CSSProperties;
}) {
  return (
    <div style={style}>
      <label style={{ display: "block", fontSize: 13, fontWeight: 500, color: "#374151", marginBottom: 6 }}>
        {label}
      </label>
      {children}
      {error && <p style={{ fontSize: 12, color: "var(--color-destructive)", marginTop: 4 }}>{error}</p>}
    </div>
  );
}
