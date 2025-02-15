import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, ValidationErrors, ValidatorFn, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';
import { MessageBannerComponent } from '../../components/message-banner/message-banner.component';
import { ErrorService } from '../../services/util/error.service';
import { IonButton, IonCol, IonContent, IonGrid, IonInput, IonInputPasswordToggle, IonRow } from '@ionic/angular/standalone';

@Component({
  selector: 'app-sign-up',
  imports: [
    ReactiveFormsModule,
    RouterLink,
    MessageBannerComponent,
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonButton,
    IonInputPasswordToggle
  ],
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.scss'],
})
export class SignUpComponent  implements OnInit {

  signUpForm = new FormGroup({
    displayName: new FormControl("", [Validators.required]),
    username: new FormControl("", [Validators.required]),
    password: new FormControl("", [Validators.required]),
    password2: new FormControl("", [Validators.required]),
  }, {
    validators: this.matchPasswordsValidator()
  })

  error?: string

  constructor(
    private auth: AuthService,
    private errors: ErrorService,
    private router: Router,
  ) { }

  ngOnInit() {}

  signUp()
  {
    this.auth.signUp({
      displayName: this.signUpForm.value.displayName ?? "",
      username: this.signUpForm.value.username ?? "",
      password: this.signUpForm.value.password ?? "",
    }).subscribe({
      complete: () => {
        this.router.navigateByUrl("/profile")
      },
      error: err => {
        const e = this.errors.getBody(err)

        if(e?.code == 400)
        {
          this.error = this.errors.get(err)
          return
        }

        this.errors.routeError(err)
      }
    })
  }

  matchPasswordsValidator(): ValidatorFn
  {
    return (_) => {
      if(!this.signUpForm)
      {
        return null
      }

      const p1 = this.signUpForm.controls["password"]
      const p2 = this.signUpForm.controls["password2"]

      if(p2.errors && p2.errors['matchPasswordsValidator'])
      {
        return null
      }

      if(p1.value != p2.value)
      {
        const error = {
          matchPasswordsValidator: "Passwords do not match"
        }

        p2.setErrors(error)

        return error
      }

      p2.setErrors(null)
      return null
    }
  }

}
