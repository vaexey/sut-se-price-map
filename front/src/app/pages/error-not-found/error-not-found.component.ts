import { Component, OnInit } from '@angular/core';
import { IonCol, IonContent, IonGrid, IonLabel, IonRow, IonTitle } from '@ionic/angular/standalone';

@Component({
  selector: 'app-error-not-found',
  imports: [
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonTitle,
    IonLabel
  ],
  templateUrl: './error-not-found.component.html',
  styleUrls: ['./error-not-found.component.scss'],
})
export class ErrorNotFoundComponent  implements OnInit {

  constructor() { }

  ngOnInit() {}

}
