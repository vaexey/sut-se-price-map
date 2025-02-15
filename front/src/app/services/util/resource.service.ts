import { Injectable } from '@angular/core';
import { Resource } from '../../model/db/Resource';
import { API_PATH } from '../API';
import { HttpClient } from '@angular/common/http';
import { DbId } from '../../model/db/dbDefs';

@Injectable({
  providedIn: 'root'
})
export class ResourceService {

  constructor(
    private http: HttpClient
  ) { }

  getDefaultResource()
  {
    return "https://ionicframework.com/docs/img/demos/thumbnail.svg"
  }

  getUrl(res: Resource | DbId | undefined)
  {
    if(res === undefined)
      return this.getDefaultResource()

    if(typeof res === "number")
      return this.getUrlFromId(res)

    return this.getUrlFromId(res.id)
  }

  getUrlFromId(resId: DbId)
  {
    return `${API_PATH}/resources/${resId}` 
  }

  fetch(res: Resource | DbId)
  {
    return this.http.get(
      this.getUrl(res)
    )
  }
}
