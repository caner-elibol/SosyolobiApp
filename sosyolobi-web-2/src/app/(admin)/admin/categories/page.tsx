"use client";

import { useEffect, useRef, useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { toast } from "sonner";
import { Plus, Pencil, Tag, ImageIcon, X } from "lucide-react";
import { BooleanBadge } from "@/components/admin/StatusBadge";
import { EmptyState } from "@/components/admin/EmptyState";
import {
  useCategories,
  useCreateCategory,
  useUpdateCategory,
  useUpdateCategoryStatus,
  useUploadCategoryImage,
  useRemoveCategoryImage,
} from "@/features/admin/categories/useCategories";
import type { AdminCategoryItem, AdminCategoryRequest } from "@/types/admin";

const schema = z.object({
  name: z.string().min(1),
  slug: z.string().min(1).regex(/^[a-z0-9-]+$/),
  iconName: z.string().optional(),
  color: z.string().optional(),
  sortOrder: z.number().int().min(0),
  isActive: z.boolean(),
});
type FormValues = z.infer<typeof schema>;

const INPUT: React.CSSProperties = {
  width: "100%", height: 42, borderRadius: 8, border: "1px solid #EBEBF0",
  padding: "0 12px", fontSize: 13, color: "#1B1D29", outline: "none",
  backgroundColor: "#F8F9FF",
};

export default function CategoriesPage() {
  const { data: categories, isLoading } = useCategories();
  const createCategory = useCreateCategory();
  const updateCategory = useUpdateCategory();
  const updateStatus = useUpdateCategoryStatus();
  const uploadImage = useUploadCategoryImage();
  const removeImage = useRemoveCategoryImage();

  const [panelOpen, setPanelOpen] = useState(false);
  const [editing, setEditing] = useState<AdminCategoryItem | null>(null);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [imagePreviewUrl, setImagePreviewUrl] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const form = useForm<FormValues>({
    resolver: zodResolver(schema),
    defaultValues: { isActive: true, sortOrder: 0 },
  });

  useEffect(() => {
    if (!editing) return;
    const fresh = categories?.find((c) => c.id === editing.id);
    if (fresh && fresh !== editing) setEditing(fresh);
  }, [categories, editing]);

  function resetImageSelection() {
    if (imagePreviewUrl) URL.revokeObjectURL(imagePreviewUrl);
    setImageFile(null);
    setImagePreviewUrl(null);
    if (fileInputRef.current) fileInputRef.current.value = "";
  }

  function openCreate() {
    setEditing(null);
    resetImageSelection();
    form.reset({ name: "", slug: "", iconName: "", color: "", sortOrder: 0, isActive: true });
    setPanelOpen(true);
  }
  function openEdit(cat: AdminCategoryItem) {
    setEditing(cat);
    resetImageSelection();
    form.reset({ name: cat.name, slug: cat.slug, iconName: cat.iconName ?? "", color: cat.color ?? "", sortOrder: cat.sortOrder, isActive: cat.isActive });
    setPanelOpen(true);
  }

  function onImageSelected(file: File | null) {
    if (imagePreviewUrl) URL.revokeObjectURL(imagePreviewUrl);
    setImageFile(file);
    setImagePreviewUrl(file ? URL.createObjectURL(file) : null);
  }

  async function onSubmit(values: FormValues) {
    const payload: AdminCategoryRequest = { name: values.name, slug: values.slug, iconName: values.iconName || undefined, color: values.color || undefined, sortOrder: values.sortOrder, isActive: values.isActive };
    try {
      if (editing) { await updateCategory.mutateAsync({ id: editing.id, data: payload }); toast.success("Güncellendi."); }
      else { await createCategory.mutateAsync(payload); toast.success("Oluşturuldu."); }
      setPanelOpen(false);
    } catch { toast.error("İşlem başarısız."); }
  }

  async function toggleStatus(cat: AdminCategoryItem) {
    try { await updateStatus.mutateAsync({ id: cat.id, isActive: !cat.isActive }); toast.success("Durum güncellendi."); }
    catch { toast.error("İşlem başarısız."); }
  }

  async function uploadSelectedImage() {
    if (!editing || !imageFile) return;
    try {
      await uploadImage.mutateAsync({ id: editing.id, file: imageFile });
      resetImageSelection();
      toast.success("Resim yüklendi.");
    } catch { toast.error("Resim yüklenemedi."); }
  }

  async function removeCurrentImage() {
    if (!editing) return;
    try { await removeImage.mutateAsync(editing.id); toast.success("Resim kaldırıldı, otomatik görsele dönüldü."); }
    catch { toast.error("Resim kaldırılamadı."); }
  }

  const cats = categories ?? [];

  return (
    <div style={{ display: "flex", gap: 24 }}>
      <div style={{ flex: 1 }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 24 }}>
          <div>
            <h2 style={{ fontSize: 22, fontWeight: 700, color: "#1B1D29" }}>Kategoriler</h2>
            <p style={{ fontSize: 13, color: "#6B7280", marginTop: 4 }}>{cats.length} kategori</p>
          </div>
          <button onClick={openCreate} style={{ display: "flex", alignItems: "center", gap: 6, height: 40, padding: "0 18px", borderRadius: 10, border: "none", backgroundColor: "#5B5FE9", color: "#fff", fontSize: 13, fontWeight: 600, cursor: "pointer" }}>
            <Plus size={14} /> Kategori Ekle
          </button>
        </div>

        <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", overflow: "hidden" }}>
          <table style={{ width: "100%", borderCollapse: "collapse" }}>
            <thead>
              <tr style={{ borderBottom: "1px solid #F0F1F5" }}>
                {["Sıra", "Ad", "Slug", "Renk", "Etkinlik", "Durum", ""].map((h) => (
                  <th key={h} style={{ textAlign: "left", padding: "13px 18px", fontSize: 12, fontWeight: 600, color: "#6B7280", backgroundColor: "#FAFBFF" }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {isLoading ? Array.from({ length: 6 }).map((_, i) => (
                <tr key={i} style={{ borderBottom: "1px solid #F8F9FF" }}>
                  {Array.from({ length: 7 }).map((_, j) => (
                    <td key={j} style={{ padding: "14px 18px" }}>
                      <div style={{ height: 14, backgroundColor: "#F0F1F5", borderRadius: 6, animation: "pulse 1.5s ease-in-out infinite" }} />
                    </td>
                  ))}
                </tr>
              )) : cats.map((cat, idx) => (
                <tr key={cat.id} style={{ borderBottom: idx < cats.length - 1 ? "1px solid #F8F9FF" : "none" }}
                  onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = "#FAFBFF")}
                  onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = "transparent")}>
                  <td style={{ padding: "13px 18px", fontSize: 13, color: "#6B7280" }}>{cat.sortOrder}</td>
                  <td style={{ padding: "13px 18px" }}>
                    <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
                      {cat.imageUrl ? (
                        // eslint-disable-next-line @next/next/no-img-element
                        <img src={cat.imageUrl} alt="" style={{ width: 28, height: 28, borderRadius: 8, objectFit: "cover", flexShrink: 0 }} />
                      ) : (
                        <div style={{ width: 28, height: 28, borderRadius: 8, backgroundColor: "#F4F5F9", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
                          <ImageIcon size={13} color="#C7CAD6" />
                        </div>
                      )}
                      {cat.color && <div style={{ width: 10, height: 10, borderRadius: "50%", backgroundColor: cat.color, flexShrink: 0 }} />}
                      <span style={{ fontSize: 14, fontWeight: 600, color: "#1B1D29" }}>{cat.name}</span>
                    </div>
                  </td>
                  <td style={{ padding: "13px 18px" }}>
                    <code style={{ fontSize: 11, color: "#6B7280", backgroundColor: "#F4F5F9", padding: "2px 8px", borderRadius: 6 }}>{cat.slug}</code>
                  </td>
                  <td style={{ padding: "13px 18px" }}>
                    {cat.color ? (
                      <div style={{ display: "flex", alignItems: "center", gap: 6 }}>
                        <div style={{ width: 20, height: 20, borderRadius: 6, backgroundColor: cat.color, border: "1px solid rgba(0,0,0,0.1)" }} />
                        <span style={{ fontSize: 11, color: "#6B7280", fontFamily: "monospace" }}>{cat.color}</span>
                      </div>
                    ) : <span style={{ color: "#D1D5DB" }}>—</span>}
                  </td>
                  <td style={{ padding: "13px 18px", fontSize: 13, color: "#1B1D29" }}>{cat.activityCount}</td>
                  <td style={{ padding: "13px 18px" }}><BooleanBadge value={cat.isActive} trueLabel="Aktif" falseLabel="Pasif" /></td>
                  <td style={{ padding: "13px 18px" }}>
                    <div style={{ display: "flex", gap: 6 }}>
                      <button onClick={() => openEdit(cat)} style={{ width: 30, height: 30, borderRadius: 8, border: "1px solid #F0F1F5", backgroundColor: "#fff", display: "flex", alignItems: "center", justifyContent: "center", cursor: "pointer", color: "#6B7280" }}>
                        <Pencil size={13} />
                      </button>
                      <button onClick={() => toggleStatus(cat)} style={{ height: 30, padding: "0 10px", borderRadius: 8, border: "1px solid #F0F1F5", backgroundColor: "#fff", fontSize: 11, fontWeight: 500, cursor: "pointer", color: cat.isActive ? "#6B7280" : "#15803D" }}>
                        {cat.isActive ? "Pasife Al" : "Aktife Al"}
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {!isLoading && cats.length === 0 && <EmptyState icon={Tag} title="Henüz kategori yok." />}
        </div>
      </div>

      {panelOpen && (
        <div style={{ width: 320, flexShrink: 0 }}>
          <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", padding: 24, position: "sticky", top: 28 }}>
            <h3 style={{ fontSize: 16, fontWeight: 700, color: "#1B1D29", marginBottom: 20 }}>
              {editing ? "Kategori Düzenle" : "Yeni Kategori"}
            </h3>

            <form onSubmit={form.handleSubmit(onSubmit)} style={{ display: "flex", flexDirection: "column", gap: 14 }}>
              {[
                { label: "Ad", name: "name" as const, placeholder: "Futbol" },
                { label: "Slug", name: "slug" as const, placeholder: "futbol" },
                { label: "İkon Adı", name: "iconName" as const, placeholder: "football" },
                { label: "Renk (hex)", name: "color" as const, placeholder: "#5B5FE9" },
              ].map(({ label, name, placeholder }) => (
                <div key={name}>
                  <label style={{ fontSize: 12, fontWeight: 500, color: "#6B7280", display: "block", marginBottom: 5 }}>{label}</label>
                  <input {...form.register(name)} placeholder={placeholder} style={INPUT} />
                </div>
              ))}

              <div>
                <label style={{ fontSize: 12, fontWeight: 500, color: "#6B7280", display: "block", marginBottom: 5 }}>
                  Kategori Resmi {editing?.imageIsCustom && <span style={{ color: "#5B5FE9", fontWeight: 600 }}>(Özel)</span>}
                </label>
                <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
                  {imagePreviewUrl || editing?.imageUrl ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img src={imagePreviewUrl ?? editing!.imageUrl!} alt="" style={{ width: 64, height: 64, borderRadius: 10, objectFit: "cover", flexShrink: 0, border: "1px solid #EBEBF0" }} />
                  ) : (
                    <div style={{ width: 64, height: 64, borderRadius: 10, backgroundColor: "#F4F5F9", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
                      <ImageIcon size={20} color="#C7CAD6" />
                    </div>
                  )}
                  <div style={{ display: "flex", flexDirection: "column", gap: 6, flex: 1 }}>
                    <input
                      ref={fileInputRef}
                      type="file"
                      accept="image/jpeg,image/png,image/webp"
                      onChange={(e) => onImageSelected(e.target.files?.[0] ?? null)}
                      style={{ fontSize: 11 }}
                    />
                    {!editing && <span style={{ fontSize: 11, color: "#9CA3AF" }}>Resim yüklemek için önce kategoriyi oluşturun.</span>}
                    {editing && (
                      <div style={{ display: "flex", gap: 6 }}>
                        {imageFile && (
                          <>
                            <button type="button" onClick={uploadSelectedImage} disabled={uploadImage.isPending}
                              style={{ height: 28, padding: "0 10px", borderRadius: 6, border: "none", backgroundColor: "#5B5FE9", color: "#fff", fontSize: 11, fontWeight: 600, cursor: "pointer" }}>
                              {uploadImage.isPending ? "Yükleniyor..." : "Yükle"}
                            </button>
                            <button type="button" onClick={resetImageSelection}
                              style={{ height: 28, width: 28, borderRadius: 6, border: "1px solid #F0F1F5", backgroundColor: "#fff", cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", color: "#6B7280" }}>
                              <X size={12} />
                            </button>
                          </>
                        )}
                        {!imageFile && editing.imageUrl && (
                          <button type="button" onClick={removeCurrentImage} disabled={removeImage.isPending}
                            style={{ height: 28, padding: "0 10px", borderRadius: 6, border: "1px solid #F0F1F5", backgroundColor: "#fff", fontSize: 11, fontWeight: 500, cursor: "pointer", color: "#DC2626" }}>
                            Resmi Kaldır
                          </button>
                        )}
                      </div>
                    )}
                  </div>
                </div>
              </div>

              <div>
                <label style={{ fontSize: 12, fontWeight: 500, color: "#6B7280", display: "block", marginBottom: 5 }}>Sıralama</label>
                <input type="number" {...form.register("sortOrder", { valueAsNumber: true })} style={INPUT} />
              </div>
              <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}>
                <label style={{ fontSize: 12, fontWeight: 500, color: "#6B7280" }}>Aktif</label>
                <button type="button" onClick={() => form.setValue("isActive", !form.watch("isActive"))}
                  style={{ width: 44, height: 24, borderRadius: 99, border: "none", backgroundColor: form.watch("isActive") ? "#5B5FE9" : "#E5E7EB", cursor: "pointer", position: "relative" }}>
                  <div style={{ width: 18, height: 18, borderRadius: "50%", backgroundColor: "#fff", position: "absolute", top: 3, left: form.watch("isActive") ? 23 : 3, transition: "left 0.15s", boxShadow: "0 1px 3px rgba(0,0,0,0.2)" }} />
                </button>
              </div>
              <div style={{ display: "flex", gap: 8, paddingTop: 4 }}>
                <button type="button" onClick={() => setPanelOpen(false)} style={{ flex: 1, height: 40, borderRadius: 8, border: "1px solid #F0F1F5", backgroundColor: "#fff", fontSize: 13, fontWeight: 500, color: "#6B7280", cursor: "pointer" }}>Vazgeç</button>
                <button type="submit" disabled={form.formState.isSubmitting} style={{ flex: 1, height: 40, borderRadius: 8, border: "none", backgroundColor: "#5B5FE9", color: "#fff", fontSize: 13, fontWeight: 600, cursor: "pointer" }}>
                  {editing ? "Güncelle" : "Oluştur"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
