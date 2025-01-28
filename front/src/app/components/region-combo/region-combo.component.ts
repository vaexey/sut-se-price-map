import { Component, OnInit } from '@angular/core';
import { RegionPickerComponent, RegionPickerDismissEvent } from '../region-picker/region-picker.component';
import { FormsModule } from '@angular/forms';
import { IonSelect, IonSelectOption } from '@ionic/angular/standalone';
import { IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { caretDownOutline } from 'ionicons/icons';

@Component({
  selector: 'app-region-combo',
  imports: [
    FormsModule,
    RegionPickerComponent,
    IonicModule, // TODO: split
  ],
  templateUrl: './region-combo.component.html',
  styleUrls: ['./region-combo.component.scss'],
})
export class RegionComboComponent  implements OnInit {

  comboText = "Everywhere"
  isOpen = false

  constructor() { 
    addIcons({
      caretDownOutline
    })
  }

  ngOnInit() {}

  open()
  {
    this.isOpen = true
  }

  onClose(evt: RegionPickerDismissEvent)
  {
    this.isOpen = false

    if(evt.selected)
    {
      this.comboText = evt.label
    }
  }
}
