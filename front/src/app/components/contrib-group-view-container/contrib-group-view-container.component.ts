import { Component, Input, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { ContribGroupViewItemComponent } from "../contrib-group-view-item/contrib-group-view-item.component";
import { GetContribsGroupResponseEntry } from '../../model/api/GetContribsGroupRequest';
import { Contrib } from '../../model/db/Contrib';
import { ContribService } from '../../services/contrib.service';
import { CurrencyPipe } from '@angular/common';

@Component({
  selector: 'app-contrib-group-view-container',
  imports: [
    IonicModule,
    ContribGroupViewItemComponent,
    CurrencyPipe,
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

  constructor(
    private contribService: ContribService
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
      error: err => {
        // TODO: err handling
        console.error(err)
      }
    })
  }

}
