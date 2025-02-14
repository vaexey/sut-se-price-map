import { Component, OnInit } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { GetProfileResponse } from '../../model/api/ProfileRequest';
import { ContribListViewComponent } from "../../components/contrib-list-view/contrib-list-view.component";
import { ProfileService } from '../../services/api/profile.service';
import { ErrorService } from '../../services/util/error.service';
import { GetContribsRequest } from '../../model/api/GetContribsRequest';
import { ResourcePipe } from "../../services/util/resource.pipe";

/**
 * THIS WHOLE COMPONENT NEEDS A REWORK ASAP
 */

@Component({
  selector: 'app-profile',
  imports: [
    IonicModule, // TODO: split
    ContribListViewComponent,
    ResourcePipe
  ],
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.scss'
})
export class ProfileComponent implements OnInit {

  profile: GetProfileResponse = {
    bio: "",
    contribCount: 0,
    defaultRegions: [],
    displayName: "",
    id: 0,
    isAdmin: false,
    isBanned: false,
    login: ""
  }

  editedProfile: GetProfileResponse = this.profile

  contribFilter: GetContribsRequest | null = null

  editable = false

  constructor(
    private profileService: ProfileService,
    private errors: ErrorService,
  ) {}

  ngOnInit(): void {
    this.profileService.getProfile().subscribe({
      next: profile => {
        this.profile = profile
        this.editedProfile = profile

        this.contribFilter = {
          users: {
            include: [profile.id]
          }
        }
      },
      error: e => {
        this.errors.routeError(e)
      }
    })
  }

  // Bogus code but deadline is approaching
  input(event: Event)
  {
    const inputEvent = event as InputEvent
    const input = inputEvent.target as HTMLElement

    const key = input.dataset["field"]!
    const value = input.innerText
    
    const map: {[key: string]: any} = {...this.profile}
    map[key] = value

    this.editedProfile = map as GetProfileResponse
  }

  edit()
  {
    this.editable = !this.editable

    if(this.editable)
      return

    this.profileService.saveProfile(this.editedProfile).subscribe({
      next: profile => {
        this.profile = profile
        this.editedProfile = profile
      },
      error: e => {
        this.errors.routeError(e)
      }
    })
  }

}
