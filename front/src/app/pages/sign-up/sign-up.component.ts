import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { IonicModule } from '@ionic/angular';

@Component({
  selector: 'app-sign-up',
  imports: [
    ReactiveFormsModule,
    RouterLink,
    IonicModule // TODO: split
  ],
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.scss'],
})
export class SignUpComponent  implements OnInit {

  signUpForm = new FormGroup({
    username: new FormControl(""),
    password: new FormControl(""),
    password2: new FormControl(""),
  })

  constructor() { }

  ngOnInit() {}

  signUp() {}

}
