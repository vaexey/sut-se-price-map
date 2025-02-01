import { Injectable } from '@angular/core';
import { ErrorResponse } from '../model/api/ErrorResponse';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class ErrorService {

  constructor(
    private router: Router
  ) { }

  get(errorResponse: any): string
  {
    const error = this.getBody(errorResponse)

    if(error)
    {
      return error.message
    }

    console.warn(
      "Unexpected error that could not be handled correctly:",
      errorResponse
    )

    return "Unexpected error that could not be handled correctly"
  }

  getBody(errorResponse: any): ErrorResponse | null
  {
    if(errorResponse instanceof HttpErrorResponse)
    {
      const error = {...errorResponse.error}

      error.code = errorResponse.status

      return error
    }

    if(typeof errorResponse === "string")
    {
      return {
        code: 500,
        message: errorResponse
      }
    }

    if(typeof errorResponse?.message === "string")
    {
      return {
        code: 500,
        message: errorResponse.message
      }
    }

    return null
  }

  routeError(errorResponse: any, defaultMessage?: string)
  {
    const e = this.getBody(errorResponse)
    const cause = e?.message ?? defaultMessage

    this.router.navigate(["/503"], {
      queryParams: {
        cause
      }
    })
  }
}
