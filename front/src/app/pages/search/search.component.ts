import { Component, OnInit, Renderer2 } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { filterCircleOutline } from 'ionicons/icons';
import { InlineSVGModule } from 'ng-inline-svg-2';
import { RegionComboComponent } from "../../components/region-combo/region-combo.component";
import { ContribGroupViewComponent } from "../../components/contrib-group-view/contrib-group-view.component";

@Component({
  selector: 'app-search',
  imports: [
    IonicModule,
    InlineSVGModule,
    RegionComboComponent,
    ContribGroupViewComponent
],
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.scss'],
})
export class SearchComponent  implements OnInit {

  constructor(
    private renderer: Renderer2
  ) {
    addIcons({
      filterCircleOutline
    })
  }

  ngOnInit() { }

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
      this.renderer.listen(elem, 'mouseover', (e) => {
        map.appendChild(elem)
      })
    })
  }

}
