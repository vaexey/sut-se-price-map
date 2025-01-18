import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class MiddlewareService implements HttpInterceptor {

  constructor(
    private auth: AuthService
  ) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>>
  {
    const token = this.auth.getToken();

    console.log("tkn", token);

    if(token)
    {
      const newRequest = req.clone({
        headers: req.headers.set(
          "Authorization",
          `Bearer ${token}`
        )
      })

      return next.handle(newRequest)
    }

    return next.handle(req);
  }
}
