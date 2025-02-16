import { Component, Input, OnInit } from '@angular/core';
import { InfiniteScrollCustomEvent } from '@ionic/angular';
import { ContribGroupViewItemComponent } from "../contrib-group-view-item/contrib-group-view-item.component";
import { Contrib } from '../../model/db/Contrib';
import { GetContribsRequest } from '../../model/api/GetContribsRequest';
import { ContribService } from '../../services/api/contrib.service';
import { ErrorService } from '../../services/util/error.service';
import { Observable, ReplaySubject } from 'rxjs';
import { addIcons } from 'ionicons';
import { pencilOutline } from 'ionicons/icons';
import { IonGrid, IonInfiniteScroll, IonInfiniteScrollContent, IonLabel, IonSkeletonText, IonTitle } from '@ionic/angular/standalone';

@Component({
  selector: 'app-contrib-list-view',
  imports: [
    ContribGroupViewItemComponent,
    IonGrid,
    IonLabel,
    IonSkeletonText,
    IonTitle,
    IonInfiniteScroll,
    IonInfiniteScrollContent
],
  templateUrl: './contrib-list-view.component.html',
  styleUrls: ['./contrib-list-view.component.scss'],
})
export class ContribListViewComponent  implements OnInit {

  private _filters: GetContribsRequest | null = null
  
  @Input() set filters(value) {
    this._filters = value

    this.onFiltersUpdate()
  }
  get filters() {
    return this._filters
  }

  @Input() autoLoad = true
  @Input() infinite = true
  @Input() limit = 20
  @Input() page = 0

  @Input() loading = true
  error: string | null = null
  availableMore: boolean = false

  @Input() contribs: Contrib[] = []

  constructor(
    private contribService: ContribService,
    private errors: ErrorService
  ) {
    addIcons({
      pencilOutline,
    })
  }
  
  ngOnInit()
  {
    if(this.autoLoad)
    {
      this.fetch()
    }
  }

  setData(data: Contrib[] | null, error?: any)
  {
    this.loading = false

    if(error || !data)
    {
      this.error = this.errors.get(error)
      this.contribs = []
      return
    }

    this.error = null
    this.contribs = data
  }

  appendData(data: Contrib[], availableMore?: boolean)
  {
    this.loading = false
    this.error = null

    this.availableMore = availableMore ?? false

    this.contribs.push(...data)
  }

  clearData()
  {
    if(this.infinite)
    {
      this.page = 0
    }

    this.loading = false
    this.error = null
    this.contribs = []
  }

  setLoading()
  {
    this.error = null

    if(this.infinite)
    {
      if(this.contribs.length === 0)
        this.loading = true

      return
    }

    this.loading = true
  }

  private onFiltersUpdate()
  {
    this.clearData()
    this.fetch()
  }

  private fetch(): Observable<void>
  {
    this.setLoading()

    const filters = this.filters ?? {}

    if(this.infinite)
    {
      filters.limit = this.limit
      filters.afterMany = (this.page) * this.limit
    }

    const replay = new ReplaySubject<void>(1)

    this.contribService.getContribs(filters).subscribe({
      next: res => {
        if(this.infinite)
        {
          this.page++
          this.appendData(res.entries, res.pages > this.page)

          return
        }

        this.setData(res.entries)
      },
      error: err => {
        this.setData(null, err)
      },
      complete: () => {
        replay.next()
        replay.complete()
      }
    })

    return replay
  }

  onScrollMore(evt: InfiniteScrollCustomEvent)
  {
    if(this.availableMore)
    {
      this.fetch().subscribe(() => {
        evt.target.complete()
      })

      return
    }

    evt.target.complete()
  }

}
