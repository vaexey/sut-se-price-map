import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, shareReplay, tap } from 'rxjs';
import { API_PATH } from '../API';
import { LoginRequest, LoginResponse } from '../../model/api/LoginRequest';
import { SignUpRequest, SignUpResponse } from '../../model/api/SignUpRequest';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(
    private http: HttpClient
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
    this.setToken(response.token)
  }

  logout()
  {
    this.setToken(null)
  }

  isLogged(): boolean
  {
    return this.getToken() != null
  }

  getToken(): string | null
  {
    return localStorage.getItem("jtoken")
  }

  setToken(token: string | null)
  {
    if(token)
    {
      localStorage.setItem("jtoken", token)
    }
    else
    {
      localStorage.removeItem("jtoken")
    }
  }
}
