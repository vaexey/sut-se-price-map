import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';
import { RegionPickerComponent, RegionPickerDismissEvent } from '../region-picker/region-picker.component';
import { FormsModule } from '@angular/forms';
import { addIcons } from 'ionicons';
import { caretDownOutline } from 'ionicons/icons';
import { DbId } from '../../model/db/dbDefs';
import { IonButton, IonIcon, IonInput, IonLabel } from '@ionic/angular/standalone';

@Component({
  selector: 'app-region-combo',
  imports: [
    FormsModule,
    RegionPickerComponent,
    IonInput,
    IonLabel,
    IonButton,
    IonIcon,    
  ],
  templateUrl: './region-combo.component.html',
  styleUrls: ['./region-combo.component.scss'],
})
export class RegionComboComponent  implements OnInit {

  @Input() isSearchResults: boolean = false;

  @Output() didSelectEvent = new EventEmitter<DbId[]>

  comboText = "Everywhere"
  isOpen = false

  constructor() { 
    addIcons({
      caretDownOutline
    })
  }

  ngOnInit() { }

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

      this.didSelectEvent.emit(evt.regions)
    }
  }
}
