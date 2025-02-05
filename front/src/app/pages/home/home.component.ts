import { Component, OnInit } from '@angular/core';
import { IonButton, IonCol, IonContent, IonGrid, IonIcon, IonInput, IonRow, IonSelect, IonSelectOption } from '@ionic/angular/standalone';
import { addIcons } from 'ionicons';
import { searchOutline } from 'ionicons/icons';
import { FormsModule } from '@angular/forms';
import { RegionComboComponent } from '../../components/region-combo/region-combo.component';

@Component({
  selector: 'app-home',
  imports: [
    FormsModule,
    RegionComboComponent,
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonInput,
    IonIcon,
    IonButton,
  ],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent implements OnInit {  
  region: string = "everywhere"

  constructor () {
    addIcons({
      searchOutline
    })
  }

  ngOnInit(): void {}
}
