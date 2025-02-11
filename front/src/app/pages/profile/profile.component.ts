import { Component } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { GetProfileResponse } from '../../model/api/GetProfileRequest';
import { ContribListViewComponent } from "../../components/contrib-list-view/contrib-list-view.component";

@Component({
  selector: 'app-profile',
  imports: [
    IonicModule, // TODO: split
    ContribListViewComponent
  ],
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.scss'
})
export class ProfileComponent {

  profile: GetProfileResponse = {
    bio: "abcdefh",
    contribCount: 2137,
    defaultRegions: [],
    displayName: "Ben",
    id: 0,
    isAdmin: true,
    isBanned: false,
    login: "ben"
  }

  editable = true

}
