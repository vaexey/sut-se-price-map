import { Attachement } from "./Attachement";
import { DbId, DbRef } from "./dbDefs";
import { Product } from "./Product";
import { Store } from "./Store";
import { User } from "./User";

export type ContribStatus = "ACTIVE" | "REVOKED" | "REMOVED"

export interface Contrib
{
    id: DbId

    // Grouped by
    product: DbRef<Product>
    store: DbRef<Store>

    // Detail view
    author: DbRef<User>
    price: number
    date: any // TODO: define date type

    // Optional detail view
    comment?: string
    attachements: DbRef<Attachement>[]

    // View status
    status: ContribStatus
}