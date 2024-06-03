import Image from "next/image";
import { Event } from "@/types";
import { Eye } from "lucide-react";

import { Badge } from "./ui/badge";
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from "./ui/card";

type EventCardProps = {
  event: Event;
};

export function EventCard({ event }: EventCardProps) {
  return (
    <Card className="flex h-60 flex-row">
      <CardHeader className="p-0">
        <Image
          src="https://t3.ftcdn.net/jpg/02/87/35/70/360_F_287357045_Ib0oYOxhotdjOEHi0vkggpZTQCsz0r19.jpg"
          alt=""
          objectFit="cover"
          width={200}
          height={400}
          className="size-full rounded-l-lg"
        />
      </CardHeader>
      <CardContent className="flex w-full flex-col justify-between p-8">
        <CardTitle className="text-xl font-bold text-purple-600/95 dark:text-purple-400">
          <p>{event.name}</p>
        </CardTitle>
        <p className="text-sm text-muted-foreground">{event.description}</p>

        <CardFooter className="flex justify-between p-0">
          <div>
            {event.inviteList.map((invite) => (
              <Badge className="mr-2" variant="outline">
                {invite.name}
              </Badge>
            ))}
          </div>
          <div className="flex">
            <Eye height={20} width={20} className="text-muted-foreground" />
            <p className="ml-2 text-sm">{event.viewAmount}</p>
          </div>
        </CardFooter>
      </CardContent>
    </Card>
  );
}
