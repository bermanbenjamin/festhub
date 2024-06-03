import { redirect } from "next/navigation";
import { Event, InviteList } from "@/types";

import { getCurrentUser } from "@/lib/session";
import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Separator } from "@/components/ui/separator";
import { DashboardHeader } from "@/components/dashboard/header";
import { DashboardShell } from "@/components/dashboard/shell";
import { EventCard } from "@/components/event-card";
import { EmptyPlaceholder } from "@/components/shared/empty-placeholder";

export const metadata = {
  title: "Dashboard",
};

export default async function DashboardPage() {
  const user = await getCurrentUser();

  const inviteLists: InviteList[] = [
    { name: "Lista VIP" },
    { name: "Lista de Tiko" },
    { name: "Lista de Berman" },
  ];

  const events: Event[] = [
    {
      name: "Tem Sambinha",
      description: "Samba na petiscaria quintal de casa",
      address: "Acupe de Brotas",
      createdAt: new Date(),
      finishDate: new Date(),
      startDate: new Date(),
      heroImageUrl: "https://image.com",
      viewAmount: 3000,
      inviteList: inviteLists,
    },
    {
      name: "Tem Sambinha",
      description: "Samba na petiscaria quintal de casa",
      address: "Acupe de Brotas",
      createdAt: new Date(),
      finishDate: new Date(),
      startDate: new Date(),
      heroImageUrl: "https://image.com",
      viewAmount: 3000,
      inviteList: inviteLists,
    },
  ];

  if (!user) {
    redirect("/login");
  }

  return (
    <DashboardShell>
      <DashboardHeader heading="Events" text="Create and manage events.">
        <Button>Create Event</Button>
      </DashboardHeader>
      <Separator />
      <ScrollArea className="h-screen">
        <div className="space-y-4 ">
          {events.map((event) => (
            <EventCard event={event} />
          ))}
        </div>
      </ScrollArea>
    </DashboardShell>
  );
}
