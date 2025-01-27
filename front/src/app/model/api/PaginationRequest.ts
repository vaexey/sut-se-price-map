import { DbDate, DbRef } from "../db/dbDefs"

// If null: do not filter using these values
export interface InExFilter<T>
{
    // Include only entries mentioning these values
    // If null: include all
    include?: DbRef<T>

    // Exclude all entries mentioning these values
    // If null: exclude none
    exclude?: DbRef<T>
}

// Group results by T and then filter
// If null: group but do not filter
export type GroupBy<T> = InExFilter<T>

// Filter results by time
// If null: do not filter
export interface TimespanFilter
{
    after?: DbDate
    before?: DbDate
}

export interface PaginationRequest
{
    // Limit maximum returned entries
    // Default: 10
    limit?: number

    // Do not show entries until this many are before
    // Default: 0
    afterMany?: number

    // Property name to sort by
    sortBy?: string
}

export interface PaginationResponse<T>
{
    // Total number of entries in collection
    total: number

    // Number of returned elements (<= limit)
    returned: number

    // Number of pages (ceil(total / limit))
    pages: number

    // Limited collection
    entries: T[]
}
