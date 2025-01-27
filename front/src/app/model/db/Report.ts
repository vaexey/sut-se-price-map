import { Contrib } from "./Contrib";
import { DbDate, DbId, DbInsert, DbRef } from "./dbDefs";
import { User } from "./User";

export interface Report
{
    id: DbId

    reported: DbRef<Contrib>
    message: string

    // Auto-generated fields
    // Any value put here should be overwritten by server
    author: DbInsert<User>
    date: DbDate
}