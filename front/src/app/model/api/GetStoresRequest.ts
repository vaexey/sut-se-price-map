import { Region } from "../db/Region";
import { InExFilter } from "./PaginationRequest";

export interface GetStoresRequest
{
    regions?: InExFilter<Region>
}