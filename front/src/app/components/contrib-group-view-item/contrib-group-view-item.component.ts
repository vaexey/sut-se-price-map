import { Component, Input, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { Contrib } from '../../model/db/Contrib';
import { CurrencyPipe, DatePipe } from '@angular/common';
import { ContribEditModalComponent, ContribEditModalEvent } from '../contrib-edit-modal/contrib-edit-modal.component';
import { ContribService } from '../../services/api/contrib.service';
import { ErrorService } from '../../services/util/error.service';
import { ResourcePipe } from "../../services/util/resource.pipe";
import { AuthService } from '../../services/auth/auth.service';
import { ContribReportModalComponent, ContribReportModalEvent } from "../contrib-report-modal/contrib-report-modal.component";
import { ReportService } from '../../services/api/report.service';

@Component({
  selector: 'app-contrib-group-view-item',
  imports: [
    IonicModule, // TODO: split
    ContribEditModalComponent,
    CurrencyPipe,
    DatePipe,
    ResourcePipe,
    ContribReportModalComponent
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
  reportModal = false

  constructor(
    private contribService: ContribService,
    private reportService: ReportService,
    private auth: AuthService,
    private errors: ErrorService,
  ) { }

  ngOnInit() {}

  edit()
  {
    this.editModal = true
  }

  report()
  {
    this.reportModal = true
  }

  thisUserId()
  {
    return this.auth.getUserId()
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

  onReportModal(event: ContribReportModalEvent) {
    this.reportModal = false

    if(event.submitted)
    {
      this.reportService.addReport({
        message: event.message,
        reported: this.contrib?.id ?? 0
      }).subscribe({
        error: e => {
          this.errors.routeError(e)
        }
      })

      return
    }
    
    if(event.removed)
    {
      if(!this.contrib)
      {
        console.error("Tried to remove nonexistent contrib")
        return
      }

      this.contrib.status = "REMOVED"

      this.contribService.updateContrib(
        this.contrib.id,
        this.contrib
      ).subscribe({
        error: e => {
          this.errors.routeError(e)
        }
      })

      return
    }
  }


}
