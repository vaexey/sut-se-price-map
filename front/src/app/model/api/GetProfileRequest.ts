import { DbId } from "../db/dbDefs";

export interface GetProfileResponse
{
    id: DbId

    login: string
    displayName: string
    bio: string
    contribCount: number
    defaultRegions: DbId[]

    isAdmin: boolean
    isBanned: boolean
}