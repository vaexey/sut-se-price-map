import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

interface helloWorldResponse {
  error: string
  message: string
  queryParam: string
}

@Injectable({
  providedIn: 'root'
})
export class HelloWorldService {  

  constructor (
    private http: HttpClient
  ) { }  

  getHelloWorld(): Observable<helloWorldResponse> {
    return this.http.get<helloWorldResponse>('/api/hello')
  }
}
