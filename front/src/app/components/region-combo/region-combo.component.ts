import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';
import { RegionPickerComponent, RegionPickerDismissEvent } from '../region-picker/region-picker.component';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { caretDownOutline } from 'ionicons/icons';
import { DbId } from '../../model/db/dbDefs';

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
