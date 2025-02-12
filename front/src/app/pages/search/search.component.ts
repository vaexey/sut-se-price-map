import { Component, OnInit, Renderer2 } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { filterCircleOutline } from 'ionicons/icons';
import { RegionComboComponent } from "../../components/region-combo/region-combo.component";
import { ContribGroupViewComponent } from "../../components/contrib-group-view/contrib-group-view.component";
import { Product } from '../../model/db/Product';
import { Store } from '../../model/db/Store';
import { StoreService } from '../../services/api/store.service';
import { ProductService } from '../../services/api/product.service';
import { DatetimeChangeEventDetail, IonDatetimeCustomEvent, IonSelectCustomEvent, SelectChangeEventDetail } from '@ionic/core'
import { GetContribsGroupRequest } from '../../model/api/GetContribsGroupRequest';
import { DbId } from '../../model/db/dbDefs';
import { ActivatedRoute, Router } from '@angular/router';
import { combineLatest } from 'rxjs';
import { RegionMapComponent } from "../../components/region-map/region-map.component";
import { PaginationSortOrder } from '../../model/api/PaginationRequest';

export type FilledGetContribsGroupRequest = 
  GetContribsGroupRequest & 
  { regions: {}, stores: {}, products: {}, timespan: {}, sortBy: string, order: PaginationSortOrder }

export type SearchQueryParams = {
  region?: string
  store?: string
  product?: string
  before?: string
  after?: string,
  sortBy?: string,
  order?: string
}

export type SortOption = {
  label: string,
  key: string,
  order: PaginationSortOrder,
}

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
    RegionComboComponent,
    ContribGroupViewComponent,
    RegionMapComponent
],
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.scss'],
})
export class SearchComponent  implements OnInit {

  private defaultFilters: FilledGetContribsGroupRequest = {
    regions: {},
    stores: {},
    products: {},
    timespan: {},
    sortBy: "date",
    order: "desc",
  }

  filters: FilledGetContribsGroupRequest = {...this.defaultFilters} 

  stores: Store[] = []
  products: Product[] = []

  sortOptions: SortOption[] = [
    {
      key: "date",
      label: "Date"
    },
  ]
  .map(({key, label}) => [
    {
      key,
      label: `${label} - ascending`,
      order: "asc" as PaginationSortOrder,
    },
    {
      key,
      label: `${label} - descending`,
      order: "desc" as PaginationSortOrder,
    },
  ]).flat()

  constructor(
    private storeService: StoreService,
    private productService: ProductService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    addIcons({
      filterCircleOutline
    })
  }

  ngOnInit() 
  {
    combineLatest([
      this.storeService.getStores(),
      this.productService.getProducts(),
      this.route.queryParams.pipe(),
    ]).subscribe(([stores, products, params]) => {
      this.stores = stores
      this.products = products

      const filters: SearchQueryParams = params
      
      this.filters.regions.include = filters.region?.split(",").map(r => +r)
      this.filters.stores.include = filters.store?.split(",").map(r => +r)
      this.filters.products.include = filters.product?.split(",").map(r => +r)
      this.filters.timespan.before = filters.before
      this.filters.timespan.after = filters.after
      this.filters.sortBy = filters.sortBy ?? this.defaultFilters.sortBy
      this.filters.order = filters.order as PaginationSortOrder ?? this.defaultFilters.order

      // TODO:
      // const newFilters = filters.region || filters.store || filters.product || filters.before || filters.after
      const newFilters = true

      this.updateFilters(!newFilters)
    })
  }

  updateFilters(noReload?: boolean)
  {
    if(!noReload)
    {
      this.filters = {
        ...this.filters
      }
    }

    // TODO: restore filters

    const params: SearchQueryParams = {
      region: this.filters.regions.include?.join(","),
      store: this.filters.stores.include?.join(","),
      product: this.filters.products.include?.join(","),
      before: this.filters.timespan.before,
      after: this.filters.timespan.after,
      sortBy: this.filters.sortBy,
      order: this.filters.order,
    }

    this.router.navigate(
      [],
      {
        relativeTo: this.route,
        queryParams: params,
      }
    )
  }

  handleSortByChange(event: SelectEvent)
  {
    console.log(event)
    let option = (event as SelectEventOf<SortOption>).target.value ?? this.sortOptions[0]

    this.filters.sortBy = option.key
    this.filters.order = option.order
    this.updateFilters()
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
    if(this.filters.stores.include.length === 0)
      this.filters.stores.include = undefined

    this.updateFilters()
  }

  handleProductChange(event: SelectEvent)
  {
    let products = (event as SelectEventOf<(Product | null)[]>).target.value ?? []

    if(products.includes(null))
      products = []

    this.filters.products.include = products.map(p => p?.id).filter(n => typeof n === 'number')
    if(this.filters.products.include.length === 0)
      this.filters.products.include = undefined

    this.updateFilters()
  }

  handleTimespanBeforeChange(event: IonDatetimeCustomEvent<DatetimeChangeEventDetail>)
  {
    const date = event.detail.value as string | undefined
    if(!date)
      return

    this.filters.timespan.before = date + "Z"
    this.updateFilters()
  }

  handleTimespanAfterChange(event: IonDatetimeCustomEvent<DatetimeChangeEventDetail>)
  {
    const date = event.detail.value as string | undefined
    if(!date)
      return

    this.filters.timespan.after = date + "Z"
    this.updateFilters()
  }

}
