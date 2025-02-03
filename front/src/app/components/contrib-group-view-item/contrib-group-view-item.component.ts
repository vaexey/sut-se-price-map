import { Component, Input, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { Contrib } from '../../model/db/Contrib';
import { CurrencyPipe, DatePipe } from '@angular/common';

@Component({
  selector: 'app-contrib-group-view-item',
  imports: [
    IonicModule, // TODO: split
    CurrencyPipe,
    DatePipe,
  ],
  templateUrl: './contrib-group-view-item.component.html',
  styleUrls: ['./contrib-group-view-item.component.scss'],
})
export class ContribGroupViewItemComponent  implements OnInit {

  @Input()
  contrib?: Contrib

  constructor() { }

  ngOnInit() {}

}
