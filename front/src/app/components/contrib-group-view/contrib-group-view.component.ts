import { Component, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { addOutline, barChartOutline, chevronDownOutline, heart, pencilOutline } from 'ionicons/icons';
import { ContribGroupViewContainerComponent } from "../contrib-group-view-container/contrib-group-view-container.component";
import { GetContribsGroupResponseEntry } from '../../model/api/GetContribsGroupRequest';

@Component({
  selector: 'app-contrib-group-view',
  imports: [
    IonicModule,
    ContribGroupViewContainerComponent
],
  templateUrl: './contrib-group-view.component.html',
  styleUrls: ['./contrib-group-view.component.scss'],
})
export class ContribGroupViewComponent  implements OnInit {

  contribGroups: GetContribsGroupResponseEntry[] = //[]
  [
    {
      product: {
        id: 0,
        name: "Milk",
        photo: {
          id: 0,
          url: ""
        },
      },
      store: {
        id: 0,
        name: "Biedronka",
        region: {
          id: 0,
          name: "Gliwice",
          parent: 0,
          parentCount: 0,
        },
      },
      region: {
        id: 0,
        name: "Gliwice",
        parent: 0,
        parentCount: 0,
      },
      firstAuthor: {
        id: 0,
        displayName: "Ben",
        avatar: {
          id: 0,
          url: "",
        }
      },
      rating: 5,
      averagePrice: 5,
      contribs: [1,2,3],
    }
  ]

  constructor() {
    addIcons({
      heart,
      barChartOutline,
      addOutline,
      chevronDownOutline,
      pencilOutline,
    })
  }

  ngOnInit() {}

}
