import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Region } from '../model/db/Region';
import { API_PATH } from './API';
import { DbId } from '../model/db/dbDefs';

@Injectable({
  providedIn: 'root'
})
export class RegionService {

  constructor(
    private http: HttpClient
  ) { }

  getRegions(): Observable<Region[]>
  {
    return this.http.get<Region[]>(`${API_PATH}/regions`)
  }

  getRegion(id: DbId): Observable<Region>
  {
    return this.http.get<Region>(`${API_PATH}/regions/${id}`)
  }
  
}
