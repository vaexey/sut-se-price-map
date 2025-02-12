import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { Contrib } from '../../model/db/Contrib';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ProductService } from '../../services/api/product.service';
import { StoreService } from '../../services/api/store.service';
import { forkJoin } from 'rxjs';
import { ErrorService } from '../../services/util/error.service';
import { Product } from '../../model/db/Product';
import { Store } from '../../model/db/Store';
import { DbId } from '../../model/db/dbDefs';

export type ContribEditModalEvent = {
  submitted: boolean,
  contrib?: Contrib,
}

@Component({
  selector: 'app-contrib-edit-modal',
  imports: [
    FormsModule,
    ReactiveFormsModule,
    IonicModule, // TODO: split
  ],
  templateUrl: './contrib-edit-modal.component.html',
  styleUrls: ['./contrib-edit-modal.component.scss'],
})
export class ContribEditModalComponent  implements OnInit {

  editForm = new FormGroup({
    product: new FormControl<DbId | null>(null),
    store: new FormControl<DbId | null>(null),
    price: new FormControl(0.01),
    comment: new FormControl(""),
  })

  products: Product[] = []
  stores: Store[] = []

  private _contrib?: Contrib
  @Input() set contrib(value) {
    this._contrib = value
    this.updateForm(value)
  }
  get contrib() {
    return this._contrib
  }
  

  public get editing() {
    return !!this.contrib
  }
  
  public get canRevoke() {
    return this.contrib?.status === 'ACTIVE'
  }

  @Output() didDismissEvent = 
    new EventEmitter<ContribEditModalEvent>()

  private _isOpen = false
  @Input() set isOpen(value) {
    this._isOpen = value

    if(value)
      this.onOpened()
  }
  get isOpen() {
    return this._isOpen
  }

  private didCancel = true

  constructor(
    private productService: ProductService,
    private storeService: StoreService,
    private errors: ErrorService,
  ) { }

  ngOnInit() {
    forkJoin([
      this.productService.getProducts(),
      this.storeService.getStores(),
    ]).subscribe({
      next: ([products, stores]) => {
        [this.products, this.stores] = [products, stores]
      },
      error: e => {
        this.errors.routeError(e)
      }
    })
  }

  updateForm(basedOn?: Contrib)
  {
    this.editForm.controls.product.setValue(basedOn?.product?.id ?? null)
    this.editForm.controls.store.setValue(basedOn?.store?.id ?? null)
    this.editForm.controls.price.setValue(basedOn?.price ?? 0.01)
    this.editForm.controls.comment.setValue(basedOn?.comment ?? "")

    ;[ // Bogus semicolon for ASI
      this.editForm.controls.store,
      this.editForm.controls.product
    ].forEach(control => {
      if(this.editing)
        control.disable()
      else
        control.enable()
    });
  }

  revoke()
  {
    if(!this.canRevoke)
      return this.dismiss()

    this.dismiss()
  }

  dismiss()
  {
    this.isOpen = false
  }

  save()
  {
    this.didCancel = false
    this.dismiss()
  }

  onOpened()
  {
    this.updateForm(this.contrib)
  }

  onDismissed()
  {
    this.didDismissEvent.emit({
      submitted: !this.didCancel,
      contrib: undefined,
    })
  }

  formatPrice(element: HTMLIonInputElement)
  {
    const value = +(element.value ?? 0)

    element.value = value.toFixed(2)
  }

}
