"use client";

import { useEffect, useState } from "react";
import { usePathname, useRouter } from "next/navigation";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "sonner";
import { Sidebar } from "@/components/admin/Sidebar";
import { Topbar } from "@/components/admin/Topbar";
import { getAdminFromToken } from "@/lib/auth";

const qc = new QueryClient({ defaultOptions: { queries: { staleTime: 30_000, retry: 1 } } });

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const router = useRouter();
  const isLogin = pathname === "/admin/login";
  const [ready, setReady] = useState(false);

  useEffect(() => {
    if (!isLogin && !getAdminFromToken()) {
      router.replace("/admin/login");
    } else {
      setReady(true);
    }
  }, [isLogin, router]);

  if (isLogin) {
    return (
      <QueryClientProvider client={qc}>
        {children}
        <Toaster richColors position="top-right" />
      </QueryClientProvider>
    );
  }

  if (!ready) return null;

  return (
    <QueryClientProvider client={qc}>
      <div style={{ display: "flex", minHeight: "100vh" }}>
        <Sidebar />
        <div style={{ flex: 1, display: "flex", flexDirection: "column", minWidth: 0 }}>
          <Topbar />
          <main style={{ flex: 1, padding: 28 }}>
            {children}
          </main>
        </div>
      </div>
      <Toaster richColors position="top-right" />
    </QueryClientProvider>
  );
}
