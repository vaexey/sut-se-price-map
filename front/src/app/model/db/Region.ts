import { DbId, DbInsert } from "./dbDefs"

export interface Region
{
    id: DbId
    parent?: DbInsert<Region>

    name: string

    parentCount: number
}