import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { AuthService } from '../../services/auth/auth.service';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { MessageBannerComponent } from '../../components/message-banner/message-banner.component';
import { ErrorService } from '../../services/util/error.service';

@Component({
  selector: 'app-login',
  imports: [
    ReactiveFormsModule,
    RouterLink,
    MessageBannerComponent,
    IonicModule // TODO: split
  ],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent  implements OnInit {

  loginForm = new FormGroup({
    username: new FormControl("", [Validators.required]),
    password: new FormControl("", [Validators.required]),
  })

  nextUrl = "/"

  error?: string

  constructor(
    private auth: AuthService,
    private errors: ErrorService,
    private router: Router,
    private route: ActivatedRoute,
  ) { }

  ngOnInit() {
    this.nextUrl = this.route.snapshot.queryParams["next"] ?? this.nextUrl
  }

  login()
  {
    this.auth.login(
      this.loginForm.value.username ?? "",
      this.loginForm.value.password ?? ""
    ).subscribe({
      complete: () => {
        this.router.navigateByUrl(this.nextUrl)
      },
      error: err => {
        const e = this.errors.getBody(err)

        if(e?.code == 401)
        {
          this.error = this.errors.get(err)
          return
        }

        this.errors.routeError(err)
      }
    })
  }

}
