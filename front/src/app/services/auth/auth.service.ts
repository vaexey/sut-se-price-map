import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, shareReplay, tap } from 'rxjs';
import { API_PATH } from '../API';
import { LoginRequest, LoginResponse } from '../../model/api/LoginRequest';
import { SignUpRequest, SignUpResponse } from '../../model/api/SignUpRequest';
import { SessionStorageService } from '../util/session-storage.service';
import { DbId } from '../../model/db/dbDefs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(
    private http: HttpClient,
    private session: SessionStorageService,
  ) { }

  login(username: string, password: string): Observable<LoginResponse>
  {
    let request: LoginRequest = {
      username,
      password
    }

    return this.http.post<LoginResponse>(`${API_PATH}/login`, request).pipe(
      tap(res => {
        this.onAuthRequestComplete(res)
      }),
      shareReplay()
    )
  }

  signUp(data: SignUpRequest): Observable<SignUpResponse>
  {
    return this.http.put<SignUpResponse>(`${API_PATH}/sign-up`, data).pipe(
      tap(res => {
        this.onAuthRequestComplete(res)
      }),
      shareReplay()
    )
  }

  private onAuthRequestComplete(response: LoginResponse | SignUpResponse)
  {
    this.session.edit(s => {
      s.token = response.token,
      s.isAdmin = response.isAdmin
    })
  }

  getUserId(): DbId | null
  {
    if(!this.isLogged())
      return null

    const id = parseInt(this.session.get().userId + "")

    if(isNaN(id))
      return null

    return id
  }

  getToken(): string | null
  {
    return this.session.get().token ?? null
  }

  logout()
  {
    this.session.edit(s => {
      s.token = undefined
      s.isAdmin = undefined
    })
  }

  isLogged(): boolean
  {
    return !!this.session.get().token
  }

  isAdmin(): boolean
  {
    return this.isLogged() && !!this.session.get().isAdmin
  }
}
