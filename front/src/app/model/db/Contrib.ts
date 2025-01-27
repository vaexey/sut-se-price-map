import { Attachement } from "./Attachement";
import { DbDate, DbId, DbInsert } from "./dbDefs";
import { Product } from "./Product";
import { Store } from "./Store";
import { User } from "./User";

export type ContribStatus = "ACTIVE" | "REVOKED" | "REMOVED"

export interface Contrib
{
    id: DbId

    // Grouped by
    product: DbInsert<Product>
    store: DbInsert<Store>

    // Detail view
    author: DbInsert<User>
    price: number
    date: DbDate

    // Optional detail view
    comment?: string
    attachements: DbInsert<Attachement>[]

    // View status
    status: ContribStatus
}