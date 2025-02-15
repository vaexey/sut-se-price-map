import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Contrib } from '../../model/db/Contrib';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ProductService } from '../../services/api/product.service';
import { StoreService } from '../../services/api/store.service';
import { forkJoin } from 'rxjs';
import { ErrorService } from '../../services/util/error.service';
import { Product } from '../../model/db/Product';
import { Store } from '../../model/db/Store';
import { DbId } from '../../model/db/dbDefs';
import { AuthService } from '../../services/auth/auth.service';
import { IonButton, IonButtons, IonCol, IonContent, IonFooter, IonGrid, IonHeader, IonInput, IonItem, IonLabel, IonList, IonModal, IonNote, IonRow, IonSelectOption, IonTitle, IonToolbar } from '@ionic/angular/standalone';

export type ContribEditModalEvent = {
  submitted: boolean,
  revoked: boolean,
  fields: ContribEditModalFields,
}

export type ContribEditModalFields = {
    product: DbId | null,
    store: DbId | null,
    price: number,
    comment: string,
  }

@Component({
  selector: 'app-contrib-edit-modal',
  imports: [
    FormsModule,
    ReactiveFormsModule,
    IonModal,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonGrid,
    IonRow,
    IonList,
    IonCol,
    IonItem,
    IonInput,
    IonSelectOption,
    IonNote,
    IonLabel,
    IonFooter,
    IonButtons,
    IonButton
  ],
  templateUrl: './contrib-edit-modal.component.html',
  styleUrls: ['./contrib-edit-modal.component.scss'],
})
export class ContribEditModalComponent  implements OnInit {

  @Input()
  defaultValues: ContribEditModalFields = {
    product: null,
    store: null,
    price: 0.01,
    comment: ""
  }

  editForm = new FormGroup({
    product: new FormControl<DbId | null>(this.defaultValues.product),
    store: new FormControl<DbId | null>(this.defaultValues.store),
    price: new FormControl(this.defaultValues.price),
    comment: new FormControl(this.defaultValues.comment),
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

  public get canEdit() {
    return this.editing &&
      (
        this.contrib?.author.id == this.auth.getUserId() ||
        this.auth.isAdmin()
      )
  }
  
  public get canRevoke() {
    return this.canEdit && this.contrib?.status === 'ACTIVE'
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
  private revokedFlag = false

  constructor(
    private productService: ProductService,
    private storeService: StoreService,
    private auth: AuthService,
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
    this.editForm.controls.product.setValue(basedOn?.product?.id ?? this.defaultValues.product)
    this.editForm.controls.store.setValue(basedOn?.store?.id ?? this.defaultValues.store)
    this.editForm.controls.price.setValue(basedOn?.price ?? this.defaultValues.price)
    this.editForm.controls.comment.setValue(basedOn?.comment ?? this.defaultValues.comment)

    ;[ // Bogus semicolon for ASI
      this.editForm.controls.store,
      this.editForm.controls.product
    ].forEach(control => {
      if(this.editing)
        control.disable()
      else
        control.enable()
    })

    ;[
      this.editForm.controls.price,
      this.editForm.controls.comment
    ].forEach(control => {
      if(!this.canEdit && this.editing)
        control.disable()
      else
        control.enable()
    })
  }

  revoke()
  {
    if(!this.canRevoke)
      return this.dismiss()

    this.revokedFlag = true
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
      revoked: this.revokedFlag,
      fields: {
        product: this.editForm.value.product ?? this.defaultValues.product,
        store: this.editForm.value.store ?? this.defaultValues.store,
        comment: this.editForm.value.comment ?? this.defaultValues.comment,
        price: this.editForm.value.price ?? this.defaultValues.price,
      }
    })

    this.revokedFlag = false
  }

  formatPrice(element: HTMLIonInputElement)
  {
    const value = +(element.value ?? 0)

    element.value = value.toFixed(2)
  }

}
