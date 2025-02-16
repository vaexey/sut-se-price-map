import { Contrib } from "../db/Contrib";
import { DbRef } from "../db/dbDefs";

export interface PutReportRequest
{
    reported: DbRef<Contrib>
    message: string
}