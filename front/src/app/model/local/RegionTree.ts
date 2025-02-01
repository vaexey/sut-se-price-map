import { DbId } from "../db/dbDefs";

export interface RegionTree
{
    id: DbId

    name: string
    parentCount: number

    children: RegionTree[]
}