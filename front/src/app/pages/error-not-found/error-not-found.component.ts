import { Component, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';

@Component({
  selector: 'app-error-not-found',
  imports: [
    IonicModule // TODO: split
  ],
  templateUrl: './error-not-found.component.html',
  styleUrls: ['./error-not-found.component.scss'],
})
export class ErrorNotFoundComponent  implements OnInit {

  constructor() { }

  ngOnInit() {}

}
