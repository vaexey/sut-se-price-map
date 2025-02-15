import { Component, EventEmitter, OnInit, Output, Renderer2 } from '@angular/core';
import { InlineSVGModule } from 'ng-inline-svg-2';
import { DbId } from '../../model/db/dbDefs';

@Component({
  selector: 'app-region-map',
  imports: [
    InlineSVGModule,
  ],
  templateUrl: './region-map.component.html',
  styleUrls: ['./region-map.component.scss'],
})
export class RegionMapComponent  implements OnInit {

  private mapMap: { [key: string]: DbId } = {
    S: 17,
    K: 18,
  }

  @Output() onRegionSelect = new EventEmitter<DbId>()

  constructor(
    private renderer: Renderer2
  ) { }

  ngOnInit() {}
  
  onMapLoad()
  {
    const map = document.querySelector(".map svg")
    const mapElements = [...document.querySelectorAll("path")]

    if(!map)
    {
      console.error("Could not load map SVG")
      return
    }

    mapElements.forEach(elem => {
      this.renderer.listen(elem, 'mouseover', _ => {
        map.appendChild(elem)
      })

      this.renderer.listen(elem, 'click', _ => {
        const region = /map_pol_(.)/.exec(elem.id)?.at(1)?.toUpperCase()

        if(region)
        {
          this.onRegionSelect.emit(this.mapMap[region])
        }
      })
    })
  }

}
