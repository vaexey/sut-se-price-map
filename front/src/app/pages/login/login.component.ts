import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { AuthService } from '../../services/auth.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-login',
  imports: [
    ReactiveFormsModule,
    IonicModule // TODO: split
  ],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent  implements OnInit {

  loginForm = new FormGroup({
    username: new FormControl(""),
    password: new FormControl(""),
  })

  nextUrl = "/";

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute,
  ) { }

  ngOnInit() {
    this.nextUrl = this.route.snapshot.queryParams["next"] ?? this.nextUrl
  }

  login()
  {
    console.log(this.loginForm.value)
    this.auth.login(
      this.loginForm.value.username ?? "",
      this.loginForm.value.password ?? ""
    ).subscribe({
      complete: () => {
        this.router.navigateByUrl(this.nextUrl)
      },
      error: err => {
        console.log(err)
      }
    })
  }

}
