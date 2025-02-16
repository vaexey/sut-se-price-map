import { Component, OnInit } from '@angular/core';
import { ReportService } from '../../services/api/report.service';
import { Report } from '../../model/db/Report';
import { IonCard, IonCardContent, IonCardHeader, IonCardSubtitle, IonCardTitle, IonCol, IonContent, IonGrid, IonItem, IonLabel, IonList, IonRow, IonTitle } from '@ionic/angular/standalone';

@Component({
  selector: 'app-admin-panel',
  imports: [
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonTitle,
    IonCard,
    IonCardHeader,
    IonCardTitle,
    IonCardSubtitle,
    IonCardContent,
    IonList,
    IonItem,
    IonLabel
  ],
  templateUrl: './admin-panel.component.html',
  styleUrls: ['./admin-panel.component.scss'],
})
export class AdminPanelComponent  implements OnInit {

  reports: Report[] = []

  constructor(
    private reportService: ReportService
  ) { }

  ngOnInit() {
    this.reportService.getReports().subscribe(reports => {
      this.reports = reports
    })
  }

}
