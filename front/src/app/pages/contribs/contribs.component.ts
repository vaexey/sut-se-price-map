import { Component, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { ContribListViewComponent } from '../../components/contrib-list-view/contrib-list-view.component';

@Component({
  selector: 'app-contribs',
    imports: [
      IonicModule, // TODO: split
      ContribListViewComponent,
  ],
  templateUrl: './contribs.component.html',
  styleUrls: ['./contribs.component.scss'],
})
export class ContribsComponent  implements OnInit {

  constructor() { }

  ngOnInit() {}

}
