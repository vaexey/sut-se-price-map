import { HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';

export type SquashableRequest = {
  [key: string]: SquashableRequestTypes | SquashableRequestTypes | SquashableRequest
}

export type SquashableRequestTypes = string | number | null | undefined

export type SquashedRequestArray = { key: string, value: string }[]

@Injectable({
  providedIn: 'root'
})
export class GetParamService {

  constructor() { }

  squashRequest(request: SquashableRequest | SquashedRequestArray): HttpParams
  {
    if(!Array.isArray(request))
    {
      request = this.squashRequestToArray(request)
    }

    let params = new HttpParams()

    request.forEach(p => {
      params = params.set(p.key, p.value)
    })

    return params
  }

  squashRequestToArray(request: SquashableRequest): SquashedRequestArray
  {
    const keys = Object.keys(request)
    let squashed: SquashedRequestArray = []
    
    keys.forEach(k => {
      const v = request[k]

      if(v === undefined || v === null)
        return

      if(typeof v === "string" || typeof v === "number")
      {
        squashed.push({
          key: k,
          value: `${v}`
        })

        return
      }

      if(Array.isArray(v) && v.length > 0)
      {
        squashed.push({
          key: k,
          value: v.join(",")
        })

        return
      }

      squashed = [
        ...squashed,
        ...this.squashRequestToArray(v).map(p => {
          return {
            key: k + p.key.charAt(0).toUpperCase() + p.key.substring(1),
            value: p.value
          }
        })
      ]
    })

    return squashed
  }
}
