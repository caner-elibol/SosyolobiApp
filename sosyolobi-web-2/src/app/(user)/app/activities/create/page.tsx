import { AppShell } from "@/components/app/AppShell";
import { CreateActivityForm } from "@/components/app/CreateActivityForm";

export default function CreateActivityPage() {
  return (
    <AppShell>
      <div style={{ maxWidth: 1100, margin: "0 auto", padding: "24px 16px 40px" }}>
        <CreateActivityForm />
      </div>
    </AppShell>
  );
}
