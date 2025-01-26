import { Injectable } from '@angular/core';
import { ErrorResponse } from '../model/api/ErrorResponse';
import { HttpErrorResponse } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ErrorService {

  constructor() { }

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

    if(typeof errorResponse.message === "string")
    {
      return {
        code: 500,
        message: errorResponse.message
      }
    }

    return null
  }
}
