import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { IonicModule } from '@ionic/angular';

@Component({
  selector: 'app-error-unavailable',
  imports: [
    IonicModule // TODO: split
  ],
  templateUrl: './error-unavailable.component.html',
  styleUrls: ['./error-unavailable.component.scss'],
})
export class ErrorUnavailableComponent  implements OnInit {

  cause: string | null = null

  constructor(
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.cause = this.route.snapshot.queryParamMap.get('cause')

    if(this.cause && !["!",".","?"].includes(this.cause.charAt(this.cause.length - 1)))
      this.cause += "."
  }

}
