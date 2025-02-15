import { Injectable } from '@angular/core';
import { SessionStorage } from '../../model/local/SessionStorage';

const SESSION_STORAGE_KEY = "pmsession"

@Injectable({
  providedIn: 'root'
})
export class SessionStorageService {

  constructor() {
    const exists = this.getRaw()

    if(!exists)
      this.save({})
  }

  get(): SessionStorage {
    const raw = this.getRaw()

    // TODO: check types
    const session: SessionStorage = (raw as SessionStorage) ?? {}

    return session as SessionStorage
  }

  save(session: SessionStorage) {
    this.saveRaw(session)
  }

  edit(editor: (session: SessionStorage) => void) {
    const session = this.get()

    editor(session)

    this.save(session)
  }

  private getRaw(): {[key: string]: any} | null {
    const string = localStorage.getItem(SESSION_STORAGE_KEY)

    if(!string)
      return null

    try {
      return JSON.parse(string)
    } catch (error) {
      console.warn("Session storage was malformed")

      return null
    }
  }

  private saveRaw(value: object | null) {
    if(value)
    {
      localStorage.setItem(SESSION_STORAGE_KEY, JSON.stringify(value))
      return
    }

    localStorage.removeItem(SESSION_STORAGE_KEY)
  }

}
