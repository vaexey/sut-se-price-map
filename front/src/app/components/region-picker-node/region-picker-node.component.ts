import { Component, EventEmitter, Input, OnInit, Output, Pipe, PipeTransform } from '@angular/core';
import { RegionTree } from '../../model/local/RegionTree';
import { RegionPickerModel } from '../region-picker/region-picker.component';
import { DbId } from '../../model/db/dbDefs';
import { IonAccordion, IonAccordionGroup, IonCheckbox, IonItem } from '@ionic/angular/standalone';

export type RegionPickerNodeModel = {
  model: RegionPickerModel,
  subtree: RegionTree,
}

export type RegionPickerNodeEvent = {
  id: DbId,
  checked: boolean,
}

@Pipe({
  name: "checkboxPipe"
})
export class RegionCheckboxPipe implements PipeTransform {
  transform(idList: DbId[], id: DbId) {
    return idList.includes(id)
  }
}

@Component({
  selector: 'app-region-picker-node',
  imports: [
    RegionCheckboxPipe,
    IonAccordionGroup,
    IonAccordion,
    IonItem,
    IonCheckbox,    
  ],
  templateUrl: './region-picker-node.component.html',
  styleUrls: ['./region-picker-node.component.scss'],
})
export class RegionPickerNodeComponent  implements OnInit {

  @Input() model?: RegionPickerNodeModel

  @Output() ionChangeEvent = new EventEmitter<RegionPickerNodeEvent>()

  constructor() { }

  ngOnInit() {}

  checked()
  {
    return !!this.model?.model.checked.includes(this.model.subtree.id)
  }

  indeterminate()
  {
    return false
    // return !!this.model?.model.indeterminate.includes(this.model.subtree.id)
  }

  onIonChange(event: any | RegionPickerNodeEvent, id: DbId)
  {
    if(event?.id && event?.checked !== undefined)
    {
      this.ionChangeEvent.emit({
        checked: event.checked,
        id: event.id
      })

      return
    }

    this.ionChangeEvent.emit({
      checked: event?.detail?.checked ?? false,
      id: id
    })
  }

}
