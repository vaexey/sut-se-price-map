import { Component, OnInit, Renderer2 } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { filterCircleOutline } from 'ionicons/icons';
import { InlineSVGModule } from 'ng-inline-svg-2';
import { RegionComboComponent } from "../../components/region-combo/region-combo.component";
import { ContribGroupViewComponent } from "../../components/contrib-group-view/contrib-group-view.component";
import { Product } from '../../model/db/Product';
import { Store } from '../../model/db/Store';
import { StoreService } from '../../services/api/store.service';
import { ProductService } from '../../services/api/product.service';
import { DatetimeChangeEventDetail, IonDatetimeCustomEvent, IonSelectCustomEvent, SelectChangeEventDetail } from '@ionic/core'
import { GetContribsGroupRequest } from '../../model/api/GetContribsGroupRequest';
import { DbId } from '../../model/db/dbDefs';

export type SelectEvent = IonSelectCustomEvent<SelectChangeEventDetail<any>>
export type SelectEventOf<T> = {
  target: {
    value?: T
  }
}


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

  filters: GetContribsGroupRequest & { regions: {}, stores: {}, products: {}, timespan: {} } = {
    regions: {},
    stores: {},
    products: {},
    timespan: {},
  }

  stores: Store[] = []
  products: Product[] = []

  constructor(
    private storeService: StoreService,
    private productService: ProductService,
    private renderer: Renderer2
  ) {
    addIcons({
      filterCircleOutline
    })
  }

  ngOnInit() 
  {
    this.storeService.getStores().subscribe(stores => {
      this.stores = stores
    })

    this.productService.getProducts().subscribe(products => {
      this.products = products
    })
  }

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

  updateFilters()
  {
    this.filters = {
      ...this.filters
    }
  }

  handleRegionChange(regions: DbId[])
  {
    this.filters.regions.include = regions
    this.updateFilters()
  }

  handleStoreChange(event: SelectEvent)
  {
    let stores = (event as SelectEventOf<(Store | null)[]>).target.value ?? []

    if(stores.includes(null))
      stores = []

    this.filters.stores.include = stores.map(s => s?.id).filter(n => typeof n === 'number')
    this.updateFilters()
  }

  handleProductChange(event: SelectEvent)
  {
    let products = (event as SelectEventOf<(Product | null)[]>).target.value ?? []

    if(products.includes(null))
      products = []

    this.filters.products.include = products.map(p => p?.id).filter(n => typeof n === 'number')
    this.updateFilters()
  }

  handleTimespanBeforeChange(event: IonDatetimeCustomEvent<DatetimeChangeEventDetail>)
  {
    this.filters.timespan.before = event.detail.value as string | undefined
    this.updateFilters()
  }

  handleTimespanAfterChange(event: IonDatetimeCustomEvent<DatetimeChangeEventDetail>)
  {
    this.filters.timespan.after = event.detail.value as string | undefined
    this.updateFilters()
  }

}
