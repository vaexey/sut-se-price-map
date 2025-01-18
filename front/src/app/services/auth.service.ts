import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { shareReplay, tap } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(
    private http: HttpClient
  ) { }

  login(username: string, password: string)
  {
    // TODO: create login response structure
    // TODO: parametrize api url
    return this.http.post<any>("/api/login", {
      username,
      password
    }).pipe(
      tap(res => {
        this.setToken(res.token)
      }),
      shareReplay()
    )
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
