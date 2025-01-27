import { Contrib, ContribStatus } from "../db/Contrib";
import { DbDate, DbInsert, DbRef } from "../db/dbDefs";
import { Product } from "../db/Product";
import { Region } from "../db/Region";
import { Store } from "../db/Store";
import { User } from "../db/User";
import { InExFilter, PaginationRequest, PaginationResponse, TimespanFilter } from "./PaginationRequest";

export interface GetContribsRequest
    extends PaginationRequest
{
    // Filter by
    ids?: InExFilter<Contrib>
    regions?: InExFilter<Region>
    stores?: InExFilter<Store>    
    products?: InExFilter<Product>
    users?: InExFilter<User>
    timespan?: TimespanFilter

    status?: ContribStatus[]
}

export interface GetContribsResponse extends 
    PaginationResponse<DbInsert<Contrib>>
{
    request: GetContribsRequest
}
