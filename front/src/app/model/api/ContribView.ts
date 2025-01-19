import { Contrib } from "../db/Contrib";
import { DbRef } from "../db/dbDefs";
import { Product } from "../db/Product";
import { Store } from "../db/Store";
import { User } from "../db/User";

export interface ContribView
{
    // Grouped by
    product: Product
    store: Store

    // Entries
    contribs: DbRef<Contrib>[]

    // Statistics
    averagePrice: number
    firstContributor: DbRef<User>
    rating: number
}