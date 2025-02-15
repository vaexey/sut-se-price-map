import { Component, Input, OnInit } from '@angular/core';
import { ContribGroupViewItemComponent } from "../contrib-group-view-item/contrib-group-view-item.component";
import { GetContribsGroupResponseEntry } from '../../model/api/GetContribsGroupRequest';
import { Contrib } from '../../model/db/Contrib';
import { ContribService } from '../../services/api/contrib.service';
import { CurrencyPipe } from '@angular/common';
import { ContribEditModalComponent, ContribEditModalEvent } from "../contrib-edit-modal/contrib-edit-modal.component";
import { ErrorService } from '../../services/util/error.service';
import { ResourcePipe } from "../../services/util/resource.pipe";
import { IonAccordion, IonAccordionGroup, IonButton, IonCard, IonCardContent, IonCol, IonGrid, IonIcon, IonLabel, IonRow, IonSkeletonText, IonThumbnail, IonTitle } from '@ionic/angular/standalone';

@Component({
  selector: 'app-contrib-group-view-container',
  imports: [
    ContribGroupViewItemComponent,
    CurrencyPipe,
    ContribEditModalComponent,
    ResourcePipe,
    IonCard,
    IonCardContent,
    IonGrid,
    IonRow,
    IonCol,
    IonThumbnail,
    IonSkeletonText,
    IonTitle,
    IonLabel,
    IonButton,
    IonIcon,
    IonAccordionGroup,
    IonAccordion
],
  templateUrl: './contrib-group-view-container.component.html',
  styleUrls: ['./contrib-group-view-container.component.scss'],
})
export class ContribGroupViewContainerComponent  implements OnInit {

  @Input()
  isOpen = false

  @Input()
  contribGroup?: GetContribsGroupResponseEntry
  contribs: Contrib[] = []

  fetchingContribs = false

  editModal = false

  constructor(
    private contribService: ContribService,
    private errors: ErrorService,
  ) { }

  ngOnInit() {}

  toggleOpen()
  {
    this.isOpen = !this.isOpen

    if(this.isOpen)
      this.fetchContribs()
  }

  fetchContribs()
  {
    this.contribs = []
    this.fetchingContribs = true

    if(!this.contribGroup)
      return

    this.contribService.getContribs({
      ids: {
        include: this.contribGroup?.contribs
      }
    }).subscribe({
      next: res => {
        this.contribs = res.entries
        this.fetchingContribs = false
      },
      error: e => {
        // TODO: err handling
        this.errors.routeError(e)
      }
    })
  }

  addNewContrib() {
    this.editModal = true
  }

  onEditModal(event: ContribEditModalEvent) {
    console.log(event)
    this.editModal = false

    if(event.submitted)
    {
      const fields = event.fields

      this.contribService.addContrib({
        ...fields,
        product: fields.product ?? 0,
        store: fields.store ?? 0,
        status: "ACTIVE",
      }).subscribe({
        next: newContrib => {
          this.contribGroup?.contribs?.push(newContrib.id)
          this.fetchContribs()
        },
        error: e => {
          this.errors.routeError(e)
        }
      })
    }
  }

}
