import { Component, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { ReportService } from '../../services/api/report.service';
import { Report } from '../../model/db/Report';

@Component({
  selector: 'app-admin-panel',
  imports: [
    IonicModule, // TODO: split
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
