import { Component, Input, OnInit } from '@angular/core';
import {  InfiniteScrollCustomEvent, IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { addOutline, barChartOutline, chevronDownOutline, heart, pencilOutline } from 'ionicons/icons';
import { ContribGroupViewContainerComponent } from "../contrib-group-view-container/contrib-group-view-container.component";
import { GetContribsGroupRequest, GetContribsGroupResponseEntry } from '../../model/api/GetContribsGroupRequest';
import { ContribService } from '../../services/api/contrib.service';
import { ErrorService } from '../../services/util/error.service';
import { Observable, ReplaySubject } from 'rxjs';

@Component({
  selector: 'app-contrib-group-view',
  imports: [
    IonicModule,
    ContribGroupViewContainerComponent,
],
  templateUrl: './contrib-group-view.component.html',
  styleUrls: ['./contrib-group-view.component.scss'],
})
export class ContribGroupViewComponent  implements OnInit {

  private _filters: GetContribsGroupRequest | null = null

  @Input() set filters(value) {
    this._filters = value

    this.onFiltersUpdate()
  }
  get filters() {
    return this._filters
  }

  @Input() autoLoad = true
  @Input() infinite = true
  @Input() limit = 10
  @Input() page = 0

  @Input() loading = true
  error: string | null = null
  availableMore: boolean = false

  @Input() contribGroups: GetContribsGroupResponseEntry[] = []

  constructor(
    private contribService: ContribService,
    private errors: ErrorService
  ) {
    addIcons({
      heart,
      barChartOutline,
      addOutline,
      chevronDownOutline,
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

  setData(data: GetContribsGroupResponseEntry[] | null, error?: any)
  {
    this.loading = false

    if(error || !data)
    {
      this.error = this.errors.get(error)
      this.contribGroups = []
      return
    }

    this.error = null
    this.contribGroups = data
  }

  appendData(data: GetContribsGroupResponseEntry[], availableMore?: boolean)
  {
    this.loading = false
    this.error = null

    this.availableMore = availableMore ?? false

    this.contribGroups.push(...data)
  }

  clearData()
  {
    if(this.infinite)
    {
      this.page = 0
    }

    this.loading = false
    this.error = null
    this.contribGroups = []
  }

  setLoading()
  {
    this.error = null

    if(this.infinite)
    {
      if(this.contribGroups.length === 0)
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

    this.contribService.getContribGroups(filters).subscribe({
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
