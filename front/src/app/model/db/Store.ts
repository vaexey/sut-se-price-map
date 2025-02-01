import { DbId, DbInsert } from "./dbDefs";
import { Region } from "./Region";

export interface Store
{
    id: DbId

    region: DbInsert<Region>
    name: string
}