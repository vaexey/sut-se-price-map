import { Component, OnInit } from '@angular/core';
import { ContribListViewComponent } from '../../components/contrib-list-view/contrib-list-view.component';
import { IonContent, IonGrid, IonRow, IonCol, IonTitle, IonCard, IonCardHeader, IonCardTitle, IonCardSubtitle, IonCardContent } from '@ionic/angular/standalone';

@Component({
  selector: 'app-contribs',
    imports: [
      ContribListViewComponent,
      IonContent,
      IonGrid,
      IonRow,
      IonCol,     
      IonTitle,
      IonCard,
      IonCardHeader,
      IonCardTitle,
      IonCardSubtitle,
      IonCardContent 
  ],
  templateUrl: './contribs.component.html',
  styleUrls: ['./contribs.component.scss'],
})
export class ContribsComponent  implements OnInit {

  constructor() { }

  ngOnInit() {}

}
