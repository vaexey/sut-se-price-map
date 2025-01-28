import { Contrib } from "../db/Contrib";
import { DbInsert, DbRef } from "../db/dbDefs";
import { Product } from "../db/Product";
import { Region } from "../db/Region";
import { Store } from "../db/Store";
import { User } from "../db/User";
import { GroupBy, InExFilter, PaginationRequest, PaginationResponse, TimespanFilter } from "./PaginationRequest";

export interface GetContribsGroupRequest
    extends PaginationRequest
{
    // Group by and filter
    regions?: GroupBy<Region>
    stores?: GroupBy<Store>
    products?: GroupBy<Product>

    // Filter by
    users?: InExFilter<User>
    timespan?: TimespanFilter
}

export interface GetContribsGroupResponseEntry
{
    // Search request (grouped by usually)
    region: DbInsert<Region>
    store: DbInsert<Store>
    product: DbInsert<Product>

    // IDs to contributions that are in that group
    contribs: DbRef<Contrib>[]

    // Found contribs 1st user
    firstAuthor: DbInsert<User>

    // Calculated stats
    averagePrice: number
    rating: number
}

export interface GetContribsGroupResponse
    extends PaginationResponse<GetContribsGroupResponseEntry>
{}
