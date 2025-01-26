import { LoginResponse } from "./LoginRequest"

export interface SignUpRequest
{
    username: string
    password: string
    displayName: string
}

export type SignUpResponse = LoginResponse
