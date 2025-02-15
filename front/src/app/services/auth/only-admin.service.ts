import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, GuardResult, MaybeAsync, Router, RouterStateSnapshot } from '@angular/router';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class OnlyAdminService implements CanActivate {

  constructor(
    private auth: AuthService,
    private router: Router
  ) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): MaybeAsync<GuardResult> {
    if(this.auth.isAdmin())
    {
      return true
    }

    if(this.auth.isLogged())
    {
      this.router.navigate(["/503"], {
        queryParams: {
          cause: "You need to be an admin to access this route"
        }
      })

      return false
    }

    this.router.navigate(["/login"], {
      queryParams: {
        next: state.url
      }
    })

    return false
  }
}
