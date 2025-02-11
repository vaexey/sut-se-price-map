import { Component, OnInit } from '@angular/core';
import { IonButton, IonCol, IonContent, IonGrid, IonIcon, IonRow, IonSelect, IonSelectOption } from '@ionic/angular/standalone';
import { addIcons } from 'ionicons';
import { searchOutline } from 'ionicons/icons';
import { FormsModule } from '@angular/forms';
import { RegionComboComponent } from '../../components/region-combo/region-combo.component';
import { RegionMapComponent } from "../../components/region-map/region-map.component";
import { Product } from '../../model/db/Product';
import { ProductService } from '../../services/api/product.service';
import { DbId } from '../../model/db/dbDefs';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  imports: [
    FormsModule,
    RegionComboComponent,
    IonContent,
    IonGrid,
    IonRow,
    IonCol,
    IonSelect,
    IonSelectOption,
    IonIcon,
    IonButton,
    RegionMapComponent
  ],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent implements OnInit {

  products: Product[] = []

  selectedProducts: (DbId | null)[] = []
  selectedRegions: DbId[] = []

  constructor (
    private productService: ProductService,
    private router: Router
  ) {
    addIcons({
      searchOutline
    })
  }

  ngOnInit() {
    this.productService.getProducts().subscribe(products => {
      this.products = products
    })
  }
  
  onRegionsUpdate(regions: DbId[]) {
    this.selectedRegions = regions
  }

  search(overrideRegions?: DbId[]) {
    type local = DbId[] | null
    
    let product: local = this.selectedProducts.filter(p => typeof p === 'number')
    let region: local = overrideRegions ?? this.selectedRegions

    if(product.length == 0)
      product = null

    if(region.length == 0)
      region = null

    this.router.navigate(["/search"], {
      queryParams: {
        region: region?.join(","),
        product: product?.join(","),
      }
    })
  }
}
