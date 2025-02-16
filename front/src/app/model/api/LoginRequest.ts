import { DbId } from "../db/dbDefs"

export interface LoginRequest
{
    username: string
    password: string
}

export interface LoginResponse
{
    token: string,
    id: DbId,
    isAdmin: boolean,
}
