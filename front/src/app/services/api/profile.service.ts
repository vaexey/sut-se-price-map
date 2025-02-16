import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { GetProfileResponse, PostProfileRequest, PostProfileResponse } from '../../model/api/ProfileRequest';
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

  getProfileOf(userLogin: string): Observable<GetProfileResponse> {
    return this.http.get<GetProfileResponse>(
      `${API_PATH}/profile/${userLogin}`
    )
  }

  saveProfile(req: PostProfileRequest): Observable<PostProfileResponse>
  {
    return this.http.post<PostProfileResponse>(
      `${API_PATH}/profile`,
      req
    )
  }
  
  saveProfileOf(req: PostProfileRequest): Observable<PostProfileResponse>
  {
    return this.http.post<PostProfileResponse>(
      `${API_PATH}/profile/${req.login}`,
      req
    )
  }
}
