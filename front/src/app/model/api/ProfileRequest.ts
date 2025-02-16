import { DbId, DbInsert } from "../db/dbDefs";
import { Resource } from "../db/Resource";

export interface GetProfileResponse
{
    id: DbId

    login: string
    displayName: string
    bio: string
    contribCount: number
    defaultRegions: DbId[]

    avatar?: DbInsert<Resource>
    isAdmin: boolean
    isBanned: boolean
}

export type PostProfileRequest = GetProfileResponse
export type PostProfileResponse = GetProfileResponse