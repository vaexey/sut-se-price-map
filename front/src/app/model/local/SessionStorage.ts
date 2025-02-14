import { DbId } from "../db/dbDefs"

export interface SessionStorage
{
    token?: string
    isAdmin?: boolean
    userId?: DbId
}