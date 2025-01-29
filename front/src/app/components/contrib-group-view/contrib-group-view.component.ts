import { Component, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';

@Component({
  selector: 'app-contrib-group-view',
  imports: [
    IonicModule, // TODO: split
  ],
  templateUrl: './contrib-group-view.component.html',
  styleUrls: ['./contrib-group-view.component.scss'],
})
export class ContribGroupViewComponent  implements OnInit {

  constructor() { }

  ngOnInit() {}

}
