"use client";

import {
  Users, CheckCircle, CalendarCheck, AlertTriangle, Star, TrendingUp,
} from "lucide-react";
import {
  AreaChart, Area, XAxis, YAxis, Tooltip, ResponsiveContainer,
  PieChart, Pie, Cell,
} from "recharts";
import { StatCard } from "@/components/admin/StatCard";
import { EmptyState } from "@/components/admin/EmptyState";
import { useDashboardStats } from "@/features/admin/dashboard/useDashboardStats";
import { formatDate } from "@/lib/format";

const PIE_COLORS = ["#3D7BF5", "#FFC542", "#FF7452", "#5B5FE9", "#15803D"];

function Card({ children, style = {} }: { children: React.ReactNode; style?: React.CSSProperties }) {
  return (
    <div style={{ backgroundColor: "#fff", borderRadius: 16, border: "1px solid #F0F1F5", ...style }}>
      {children}
    </div>
  );
}

function CardHeader({ title, action }: { title: string; action?: React.ReactNode }) {
  return (
    <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "20px 24px 0" }}>
      <h3 style={{ fontSize: 16, fontWeight: 700, color: "#1B1D29" }}>{title}</h3>
      {action}
    </div>
  );
}

function CustomDot(props: { cx?: number; cy?: number; payload?: { highlight?: boolean } }) {
  const { cx = 0, cy = 0, payload } = props;
  if (!payload?.highlight) return <circle cx={cx} cy={cy} r={3} fill="#fff" stroke="#5B5FE9" strokeWidth={2} />;
  return (
    <g>
      <line x1={cx} y1={cy} x2={cx} y2={cy + 80} stroke="#5B5FE9" strokeDasharray="3 3" strokeWidth={1} />
      <circle cx={cx} cy={cy} r={5} fill="#fff" stroke="#5B5FE9" strokeWidth={2} />
      <foreignObject x={cx - 44} y={cy - 72} width={88} height={52}>
        <div style={{ backgroundColor: "#0E1330", borderRadius: 10, padding: "6px 10px", textAlign: "center" }}>
          <div style={{ fontSize: 10, color: "rgba(255,255,255,0.6)" }}>Kayıt</div>
          <div style={{ fontSize: 14, fontWeight: 700, color: "#fff" }}>{payload ? (props as { payload: { count?: number } }).payload.count ?? "" : ""}</div>
        </div>
      </foreignObject>
    </g>
  );
}

function Skel({ w = "100%", h = 16 }: { w?: string | number; h?: number }) {
  return <div style={{ width: w, height: h, backgroundColor: "#F0F1F5", borderRadius: 8, animation: "pulse 1.5s ease-in-out infinite" }} />;
}

export default function DashboardPage() {
  const { data: stats, isLoading } = useDashboardStats();

  const regData = (stats?.registrationsByDay ?? []).map((d, i, arr) => ({
    ...d,
    highlight: i === Math.floor(arr.length / 2),
  }));

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 24 }}>
      <div>
        <h2 style={{ fontSize: 22, fontWeight: 700, color: "#1B1D29" }}>Dashboard</h2>
        <p style={{ fontSize: 13, color: "#6B7280", marginTop: 4 }}>Platform genel durum özeti</p>
      </div>

      <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(200px, 1fr))", gap: 16 }}>
        {isLoading ? Array.from({ length: 4 }).map((_, i) => (
          <div key={i} style={{ backgroundColor: "#fff", borderRadius: 16, padding: 20, border: "1px solid #F0F1F5", height: 96 }} />
        )) : (
          <>
            <StatCard icon={Users}        label="Toplam Kullanıcı"  value={stats?.totalUsers ?? 0}       iconBg="#E7F1FF" iconColor="#3D8BFF" />
            <StatCard icon={CheckCircle}  label="Doğrulanmış"       value={stats?.verifiedUsers ?? 0}    iconBg="#DCFCE7" iconColor="#15803D" />
            <StatCard icon={CalendarCheck}label="Aktif Etkinlik"    value={stats?.activeActivities ?? 0} iconBg="#FFF6DE" iconColor="#B45309" />
            <StatCard icon={AlertTriangle}label="Bekleyen Şikayet"  value={stats?.pendingReports ?? 0}   iconBg="#FFEAE8" iconColor="#FF6B6B" />
            <StatCard icon={Star}         label="Ort. Puan"         value={stats?.averageRating?.toFixed(1) ?? "—"} iconBg="#EFEAFE" iconColor="#7B61FF" />
            <StatCard icon={CalendarCheck}label="Bugünkü Etkinlik"  value={stats?.todayActivities ?? 0}  iconBg="#E5F8FB" iconColor="#1FB6D2" />
          </>
        )}
      </div>

      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 300px", gap: 20 }}>
        <Card>
          <CardHeader title="Kullanıcı Kaydı — Son 7 Gün" />
          <div style={{ padding: "16px 24px 20px" }}>
            {isLoading ? <Skel h={180} /> : (
              <ResponsiveContainer width="100%" height={180}>
                <AreaChart data={regData} margin={{ top: 16, right: 8, bottom: 0, left: -16 }}>
                  <defs>
                    <linearGradient id="regG" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#5B5FE9" stopOpacity={0.15} />
                      <stop offset="95%" stopColor="#5B5FE9" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <XAxis dataKey="date" tickFormatter={(v) => v.slice(5)} tick={{ fontSize: 11, fill: "#6B7280" }} axisLine={false} tickLine={false} />
                  <YAxis tick={{ fontSize: 11, fill: "#6B7280" }} axisLine={false} tickLine={false} allowDecimals={false} />
                  <Tooltip
                    contentStyle={{ borderRadius: 10, border: "1px solid #F0F1F5", fontSize: 12 }}
                    formatter={(v) => [v, "Kayıt"]}
                    labelFormatter={(l) => formatDate(l)}
                  />
                  <Area
                    type="monotone" dataKey="count" stroke="#5B5FE9" strokeWidth={2}
                    fill="url(#regG)"
                    dot={<CustomDot />}
                    activeDot={{ r: 5, fill: "#5B5FE9" }}
                  />
                </AreaChart>
              </ResponsiveContainer>
            )}
          </div>
        </Card>

        <Card>
          <CardHeader title="Etkinlik Oluşturma — Son 7 Gün" />
          <div style={{ padding: "16px 24px 20px" }}>
            {isLoading ? <Skel h={180} /> : (
              <ResponsiveContainer width="100%" height={180}>
                <AreaChart data={stats?.activitiesByDay ?? []} margin={{ top: 16, right: 8, bottom: 0, left: -16 }}>
                  <defs>
                    <linearGradient id="actG" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#FFC542" stopOpacity={0.2} />
                      <stop offset="95%" stopColor="#FFC542" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <XAxis dataKey="date" tickFormatter={(v) => v.slice(5)} tick={{ fontSize: 11, fill: "#6B7280" }} axisLine={false} tickLine={false} />
                  <YAxis tick={{ fontSize: 11, fill: "#6B7280" }} axisLine={false} tickLine={false} allowDecimals={false} />
                  <Tooltip
                    contentStyle={{ borderRadius: 10, border: "1px solid #F0F1F5", fontSize: 12 }}
                    formatter={(v) => [v, "Etkinlik"]}
                    labelFormatter={(l) => formatDate(l)}
                  />
                  <Area
                    type="monotone" dataKey="count" stroke="#FFC542" strokeWidth={2}
                    fill="url(#actG)" dot={false} activeDot={{ r: 5, fill: "#FFC542" }}
                  />
                </AreaChart>
              </ResponsiveContainer>
            )}
          </div>
        </Card>

        <Card>
          <CardHeader title="Kategoriler" />
          <div style={{ padding: "16px 24px 20px" }}>
            {isLoading ? <Skel h={180} /> : (stats?.categoryDistribution?.length ?? 0) === 0 ? (
              <EmptyState title="Veri yok" />
            ) : (
              <>
                <ResponsiveContainer width="100%" height={140}>
                  <PieChart>
                    <Pie data={stats!.categoryDistribution} dataKey="count" nameKey="categoryName"
                      cx="50%" cy="50%" innerRadius={40} outerRadius={64} paddingAngle={3}>
                      {stats!.categoryDistribution.map((_, i) => (
                        <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip contentStyle={{ borderRadius: 10, border: "1px solid #F0F1F5", fontSize: 12 }} />
                  </PieChart>
                </ResponsiveContainer>
                <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
                  {stats!.categoryDistribution.slice(0, 4).map((c, i) => (
                    <div key={c.categoryName} style={{ display: "flex", alignItems: "center", gap: 8 }}>
                      <div style={{ width: 8, height: 8, borderRadius: "50%", backgroundColor: PIE_COLORS[i % PIE_COLORS.length], flexShrink: 0 }} />
                      <span style={{ fontSize: 12, color: "#1B1D29", flex: 1, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{c.categoryName}</span>
                      <span style={{ fontSize: 12, fontWeight: 600, color: "#6B7280" }}>{c.count}</span>
                    </div>
                  ))}
                </div>
              </>
            )}
          </div>
        </Card>
      </div>
    </div>
  );
}
