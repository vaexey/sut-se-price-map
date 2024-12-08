import { Component, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { filterCircleOutline } from 'ionicons/icons';
import { InlineSVGModule } from 'ng-inline-svg-2';

@Component({
  selector: 'app-search',
  imports: [
    IonicModule,
    InlineSVGModule,
  ],
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.scss'],
})
export class SearchComponent  implements OnInit {

  constructor() {
    addIcons({
      filterCircleOutline
    })
  }

  ngOnInit() {}

}
