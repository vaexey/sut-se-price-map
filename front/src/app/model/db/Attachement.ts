import { DbId, DbRef } from "./dbDefs"
import { Resource } from "./Resource"

export type AttachementType = "IMAGE" | "VIDEO"

export interface Attachement
{
    id: DbId

    type: AttachementType
    
    resource: DbRef<Resource>
    title?: string
}