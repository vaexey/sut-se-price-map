import { Component, Input, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { Contrib } from '../../model/db/Contrib';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { ContribEditModalComponent } from '../contrib-edit-modal/contrib-edit-modal.component';

@Component({
  selector: 'app-contrib-group-view-item',
  imports: [
    IonicModule, // TODO: split
    ContribEditModalComponent,
    CurrencyPipe,
    DatePipe,
  ],
  templateUrl: './contrib-group-view-item.component.html',
  styleUrls: ['./contrib-group-view-item.component.scss'],
})
export class ContribGroupViewItemComponent  implements OnInit {

  @Input()
  contrib?: Contrib

  editModal = false

  constructor() { }

  ngOnInit() {}

  edit()
  {
    this.showEditModal()
  }

  showEditModal() {
    this.editModal = true
  }

  onEditModal(event: any) {
    this.editModal = false
  }


}
