import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { IonButton, IonButtons, IonHeader, IonIcon, IonToolbar } from '@ionic/angular/standalone';
import { addIcons } from 'ionicons';
import { addCircleOutline, compassOutline, heartCircleOutline, personCircleOutline, shieldHalfOutline } from 'ionicons/icons';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-nav-bar',
  imports: [
    RouterLink,
    IonHeader,
    IonToolbar,
    IonButtons,
    IonButton,
    IonIcon,
  ],
  templateUrl: './nav-bar.component.html',
  styleUrl: './nav-bar.component.scss'
})
export class NavBarComponent {

  constructor(
    private auth: AuthService
  ) {
    addIcons({
      compassOutline,
      shieldHalfOutline,
      addCircleOutline,
      heartCircleOutline,
      personCircleOutline,
    })
  }

  logout()
  {
    this.auth.logout();
  }

  user(): boolean
  {
    return this.auth.isLogged()
  }

  admin(): boolean
  {
    return this.auth.isAdmin()
  }

}
