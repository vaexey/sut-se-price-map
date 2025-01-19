import { DbId, DbRef } from "./dbDefs";
import { Region } from "./Region";

export interface Store
{
    id: DbId

    region: DbRef<Region>
    name: string
}