import { DbId, DbInsert, DbRef } from "./dbDefs";
import { Resource } from "./Resource";

export interface User
{
    id: DbId

    displayName: string
    avatar: DbInsert<Resource>
}