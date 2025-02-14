import { Component, Input, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { Contrib } from '../../model/db/Contrib';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { ContribEditModalComponent, ContribEditModalEvent } from '../contrib-edit-modal/contrib-edit-modal.component';
import { ContribService } from '../../services/api/contrib.service';
import { ErrorService } from '../../services/util/error.service';
import { ResourcePipe } from "../../services/util/resource.pipe";

@Component({
  selector: 'app-contrib-group-view-item',
  imports: [
    IonicModule, // TODO: split
    ContribEditModalComponent,
    CurrencyPipe,
    DatePipe,
    ResourcePipe
],
  templateUrl: './contrib-group-view-item.component.html',
  styleUrls: ['./contrib-group-view-item.component.scss'],
})
export class ContribGroupViewItemComponent  implements OnInit {

  @Input()
  showGroupDetails = true

  @Input()
  showUserAvatar = true

  @Input()
  contrib?: Contrib

  editModal = false

  constructor(
    private contribService: ContribService,
    private errors: ErrorService,
  ) { }

  ngOnInit() {}

  edit()
  {
    this.showEditModal()
  }

  showEditModal() {
    this.editModal = true
  }

  onEditModal(event: ContribEditModalEvent) {
    console.log(event)
    this.editModal = false

    if(event.submitted)
    {
      if(!this.contrib?.id)
      {
        console.error("Tried to edit nonexistent contrib")
        return
      }

      const fields = event.fields

      this.contribService.updateContrib(this.contrib?.id, {
        ...fields,
        status: event.revoked ? "REVOKED" : "ACTIVE",
      }).subscribe({
        next: newContrib => {
          this.contrib = newContrib
        },
        error: e => {
          this.errors.routeError(e)
        }
      })
    }
  }


}
