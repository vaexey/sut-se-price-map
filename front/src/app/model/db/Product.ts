import { DbId, DbInsert, DbRef } from "./dbDefs"
import { Resource } from "./Resource"

export interface Product
{
    id: DbId

    photo: DbInsert<Resource>
    name: string
}