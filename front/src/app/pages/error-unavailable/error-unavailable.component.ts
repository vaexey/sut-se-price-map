import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { IonCol, IonContent, IonGrid, IonLabel, IonRow, IonTitle } from '@ionic/angular/standalone';

@Component({
  selector: 'app-error-unavailable',
  imports: [
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonTitle,
    IonLabel
  ],
  templateUrl: './error-unavailable.component.html',
  styleUrls: ['./error-unavailable.component.scss'],
})
export class ErrorUnavailableComponent  implements OnInit {

  cause: string | null = null

  constructor(
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.cause = this.route.snapshot.queryParamMap.get('cause')

    if(this.cause && !["!",".","?"].includes(this.cause.charAt(this.cause.length - 1)))
      this.cause += "."
  }

}
