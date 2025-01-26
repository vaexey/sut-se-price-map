import { Component, Input, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';

export type MessageBannerType = 
  "info" |
  "warning" |
  "error"

@Component({
  selector: 'app-message-banner',
  imports: [
    IonicModule, // TODO: Split
  ],
  templateUrl: './message-banner.component.html',
  styleUrls: ['./message-banner.component.scss'],
})
export class MessageBannerComponent  implements OnInit {

  @Input()
  hidden = false

  @Input()
  type: MessageBannerType = "info"

  @Input("title")
  setTitle?: string

  defaultTitles: {[key in MessageBannerType]: string} = {
    info: "Information",
    warning: "Warning",
    error: "Error",
  }

  colors: {[key in MessageBannerType]: string} = {
    info: "tertiary",
    warning: "warning",
    error: "danger",
  }

  constructor() { }

  ngOnInit() {}

}
