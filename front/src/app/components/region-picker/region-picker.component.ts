import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { RegionService } from '../../services/region.service';
import { RegionTree } from '../../model/local/RegionTree';
import { RegionPickerNodeComponent, RegionPickerNodeEvent } from "../region-picker-node/region-picker-node.component";
import { DbId } from '../../model/db/dbDefs';

export type RegionPickerDismissEvent = {
  selected: boolean,

  regions: DbId[],
  label: string,
}

export type RegionPickerModel = {
  tree: RegionTree,

  checked: DbId[],
  indeterminate: DbId[],
}

@Component({
  selector: 'app-region-picker',
  imports: [
    IonicModule,
    RegionPickerNodeComponent
],
  templateUrl: './region-picker.component.html',
  styleUrls: ['./region-picker.component.scss'],
})
export class RegionPickerComponent  implements OnInit {

  @Output() didDismissEvent = 
    new EventEmitter<RegionPickerDismissEvent>()

  @Input() multiple = true

  @Input() isOpen = false
  private didCancel = true

  model: RegionPickerModel = {
    tree: {
      id: 0,
      name: "...",
      parentCount: 0,
      children: []
    },

    checked: [],
    indeterminate: []
  }

  constructor(
    private regionService: RegionService
  ) { }

  ngOnInit()
  {
    this.regionService.getRegionsTree().subscribe(res => {
      this.model.tree = res
    })
  }

  dismiss()
  {
    this.isOpen = false
  }

  select()
  {
    this.didCancel = false
    this.dismiss()
  }

  onDismissed()
  {
    this.didDismissEvent.emit({
      selected: !this.didCancel,

      regions: this.model.checked,
      label: `[${this.model.checked.join(", ")}]`
    })
  }

  onIonChange(evt: RegionPickerNodeEvent)
  {
    console.log(evt)

    const id = evt.id

    let checked = [...this.model.checked]
    let inter: DbId[] = []

    if(evt.checked)
    {
      this.propagateChecks(id, this.model.tree, checked, inter)
    } else {
      checked = checked.filter(cid => cid != id)

      // this.propagateUnchecks(false, this.model.tree, checked, inter)
    }

    this.model.checked = checked
    this.model.indeterminate = inter
  }

  private propagateChecks(id: DbId, r: RegionTree, checked: DbId[], inter: DbId[], uncheck?: DbId): boolean
  {
    let thisInter = false
    let thisCheck = false

    if(id == r.id || id == -1)
    {
      thisCheck = true
    }

    r.children.forEach(c => {
      if(thisCheck || c.id == id)
      {
        const found = this.propagateChecks(-1, c, checked, inter)
        thisInter = thisInter || found

        if(!checked.includes(c.id))
          checked.push(c.id)
      }
      else
      {
        const found = this.propagateChecks(id, c, checked, inter)
        thisInter = thisInter || found
      }
    })

    if(thisCheck && !checked.includes(r.id))
      checked.push(r.id)

    if(thisInter && !thisCheck && !inter.includes(r.id))
      inter.push(r.id)
    
    return thisInter || thisCheck
  }
}
