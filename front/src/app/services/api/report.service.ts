import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { PutReportRequest } from '../../model/api/PutReportRequest';
import { API_PATH } from '../API';
import { Observable } from 'rxjs';
import { Report } from '../../model/db/Report';
import { GetReportsRequest } from '../../model/api/GetReportsRequest';
import { GetParamService, SquashableRequest } from './get-param.service';

@Injectable({
  providedIn: 'root'
})
export class ReportService {

  constructor(
    private http: HttpClient,
    private getParam: GetParamService
  ) { }

  addReport(req: PutReportRequest)
  {
    return this.http.put<Report>(
      `${API_PATH}/reports`,
      req
    )
  }

  getReports(req?: GetReportsRequest): Observable<Report[]>
  {
    return this.http.get<Report[]>(
      `${API_PATH}/reports`,
      {
        params: this.getParam.squashRequest(req as SquashableRequest ?? {})
      }
    )
  }
}
