import { ContribStatus } from "../db/Contrib";
import { DbRef } from "../db/dbDefs";
import { Product } from "../db/Product";
import { Store } from "../db/Store";

export interface PostContribRequest
{
    // Fields that can be edited by author
    price: number
    comment?: string

    // Field that can be:
    // 1. set by admin to whatever valid value
    // 2. set from ACTIVE to REVOKED by author once
    // 3. if contrib created by non-admin, set to ACTIVE regardless
    status?: ContribStatus
}

export interface PutContribRequest
    extends PostContribRequest
{
    // Fields that can be set only on creation
    product: DbRef<Product>
    store: DbRef<Store>
}