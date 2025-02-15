import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GetContribsRequest, GetContribsResponse } from '../../model/api/GetContribsRequest';
import { Observable } from 'rxjs';
import { API_PATH } from '../API';
import { GetParamService, SquashableRequest } from './get-param.service';
import { GetContribsGroupRequest, GetContribsGroupResponse } from '../../model/api/GetContribsGroupRequest';
import { Contrib } from '../../model/db/Contrib';
import { PostContribRequest, PutContribRequest } from '../../model/api/ContribRequest';
import { DbId } from '../../model/db/dbDefs';

@Injectable({
  providedIn: 'root'
})
export class ContribService {

  constructor(
    private http: HttpClient,
    private getParam: GetParamService
  ) { }

  getContribs(request: GetContribsRequest): Observable<GetContribsResponse>
  {
    return this.http.get<GetContribsResponse>(
      `${API_PATH}/contribs`,
      {
        params: this.getParam.squashRequest(request as SquashableRequest)
      }
    )
  }

  getContribGroups(request: GetContribsGroupRequest): Observable<GetContribsGroupResponse>
  {
    return this.http.get<GetContribsGroupResponse>(
      `${API_PATH}/contribs/group`,
      {
        params: this.getParam.squashRequest(request as SquashableRequest)
      }
    )
  }

  updateContrib(id: DbId, req: PostContribRequest): Observable<Contrib>
  {
    return this.http.post<Contrib>(
      `${API_PATH}/contribs/${id}`,
      req
    )
  }

  addContrib(req: PutContribRequest): Observable<Contrib>
  {
    return this.http.put<Contrib>(
      `${API_PATH}/contribs`,
      req
    )
  }
}
