import { Component } from '@angular/core';
import { IonButton, IonButtons, IonHeader, IonIcon, IonTitle, IonToolbar } from '@ionic/angular/standalone';
import { addIcons } from 'ionicons';
import { addCircleOutline, heartCircleOutline, personCircleOutline, shieldHalfOutline } from 'ionicons/icons';

@Component({
  selector: 'app-nav-bar',
  imports: [
    IonHeader,
    IonToolbar,
    IonButtons,
    IonTitle,
    IonButton,
    IonIcon,
  ],
  templateUrl: './nav-bar.component.html',
  styleUrl: './nav-bar.component.scss'
})
export class NavBarComponent {

  constructor() {
    addIcons({
      shieldHalfOutline,
      addCircleOutline,
      heartCircleOutline,
      personCircleOutline,
    })
  }

}
