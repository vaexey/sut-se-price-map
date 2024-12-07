import { Component, OnInit } from '@angular/core';
import { HelloWorldService } from '../../services/hello-world.service';
import { IonButton, IonCol, IonContent, IonGrid, IonIcon, IonInput, IonRow, IonSelect, IonSelectOption } from '@ionic/angular/standalone';
import { addIcons } from 'ionicons';
import { searchOutline } from 'ionicons/icons';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-home',
  imports: [
    FormsModule,
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonInput,
    IonIcon,
    IonButton,
    IonSelect,
    IonSelectOption,
  ],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent implements OnInit {  
  region: string = "everywhere"

  constructor (
    private helloWorldService: HelloWorldService
  ) {
    addIcons({
      searchOutline
    })
  }

  ngOnInit(): void {
    // this.helloWorldService.getHelloWorld().subscribe((response) => {
    //     this.message = response.message
    // })
  }
}
