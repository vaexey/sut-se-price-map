import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Contrib } from '../../model/db/Contrib';
import { AuthService } from '../../services/auth/auth.service';
import { IonButton, IonButtons, IonCol, IonContent, IonFooter, IonGrid, IonHeader, IonInput, IonItem, IonList, IonModal, IonRow, IonTitle, IonToolbar } from '@ionic/angular/standalone';

export type ContribReportModalEvent = {
  submitted: boolean,
  removed: boolean,
  message: string,
}

@Component({
  selector: 'app-contrib-report-modal',
  imports: [
    FormsModule,
    ReactiveFormsModule,
    IonModal,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonList,
    IonItem,
    IonInput,
    IonFooter,
    IonButtons,
    IonButton
  ],
  templateUrl: './contrib-report-modal.component.html',
  styleUrls: ['./contrib-report-modal.component.scss'],
})
export class ContribReportModalComponent  implements OnInit {

  @Input() contrib?: Contrib

  reportForm = new FormGroup({
    message: new FormControl<string>(""),
  })

  canRemove = false

  @Output() didDismissEvent = 
    new EventEmitter<ContribReportModalEvent>()

  @Input() isOpen = false
  private didCancel = true
  private didRemove = false

  constructor(
    private auth: AuthService
  ) { }

  ngOnInit() {
    this.canRemove = this.auth.isAdmin()
  }

  dismiss()
  {
    this.isOpen = false
  }

  save()
  {
    this.didCancel = false
    this.dismiss()
  }

  remove()
  {
    this.didCancel = true
    this.didRemove = true
    this.dismiss()
  }

  onDismissed()
  {
    this.didDismissEvent.emit({
      submitted: !this.didCancel,
      removed: this.didRemove,
      message: this.reportForm.value.message ?? ""
    })
  }
}
