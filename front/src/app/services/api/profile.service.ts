import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetProfileResponse } from '../../model/api/GetProfileRequest';
import { API_PATH } from '../API';

@Injectable({
  providedIn: 'root'
})
export class ProfileService {

  constructor(
    private http: HttpClient
  ) {}

  getProfile(): Observable<GetProfileResponse>
  {
    return this.http.get<GetProfileResponse>(
      `${API_PATH}/profile`
    )
  }
}
