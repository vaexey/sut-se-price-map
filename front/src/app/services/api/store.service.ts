import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Store } from '../../model/db/Store';
import { API_PATH } from '../API';
import { GetStoresRequest } from '../../model/api/GetStoresRequest';
import { GetParamService, SquashableRequest } from './get-param.service';

@Injectable({
  providedIn: 'root'
})
export class StoreService {

  constructor(
    private http: HttpClient,
    private getParam: GetParamService,
  ) { }

  getStores(request?: GetStoresRequest): Observable<Store[]>
  {
    return this.http.get<Store[]>(
      `${API_PATH}/stores`,
      {
        params: this.getParam.squashRequest(
          (request ?? {}) as SquashableRequest
        )
      }
    )
  }
}
