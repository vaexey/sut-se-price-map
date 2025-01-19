import { DbId, DbRef } from "./dbDefs"

export interface Region
{
    id: DbId
    parent: DbRef<Region>

    name: string
}