import { Component, Input, OnInit } from '@angular/core';
import {  InfiniteScrollCustomEvent, IonicModule } from '@ionic/angular';
import { addIcons } from 'ionicons';
import { addOutline, barChartOutline, chevronDownOutline, heart, pencilOutline } from 'ionicons/icons';
import { ContribGroupViewContainerComponent } from "../contrib-group-view-container/contrib-group-view-container.component";
import { GetContribsGroupRequest, GetContribsGroupResponse, GetContribsGroupResponseEntry } from '../../model/api/GetContribsGroupRequest';
import { ContribService } from '../../services/contrib.service';
import { ErrorService } from '../../services/error.service';
import { Observable, ReplaySubject } from 'rxjs';

@Component({
  selector: 'app-contrib-group-view',
  imports: [
    IonicModule,
    ContribGroupViewContainerComponent
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

  appendData(data: GetContribsGroupResponseEntry[])
  {
    this.loading = false
    this.error = null

    this.contribGroups = [
      ...this.contribGroups,
      ...data
    ]
  }

  clearData()
  {
    if(this.autoLoad && this.infinite)
    {
      this.page = 0
    }

    this.loading = false
    this.error = null
    this.contribGroups = []
  }

  setLoading()
  {
    this.loading = true
    this.error = null
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

    if(this.autoLoad && this.infinite)
    {
      filters.limit = this.limit
      filters.afterMany = (this.page + 1) * this.limit
    }

    const replay = new ReplaySubject<void>(1)

    this.contribService.getContribGroups(filters).subscribe({
      next: res => {
        if(this.autoLoad && this.infinite)
        {
          this.appendData(res.entries)
          this.page++

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
    console.log(evt)

    this.fetch().subscribe(() => {
      evt.target.complete()
    })
  }

}
