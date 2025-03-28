import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { Region } from '../../model/db/Region';
import { API_PATH } from '../API';
import { DbId } from '../../model/db/dbDefs';
import { RegionTree } from '../../model/local/RegionTree';

@Injectable({
  providedIn: 'root'
})
export class RegionService {

  constructor(
    private http: HttpClient
  ) { }

  getRegions(): Observable<Region[]>
  {
    return this.http.get<Region[]>(`${API_PATH}/regions`)
  }

  getRegionsTree(): Observable<RegionTree>
  {
    return this.getRegions().pipe(
      map(rs => this.regionsToRegionTree(rs))
    )
  }

  getRegion(id: DbId): Observable<Region>
  {
    return this.http.get<Region>(`${API_PATH}/regions/${id}`)
  }

  regionsToRegionTree(regions: Region[]): RegionTree
  {
    let root = regions.find(r => r.parentCount == 0)

    if(!root)
      throw "Could not parse region tree"
    
    return this.findChildrenOf(root, regions)
  }

  private findChildrenOf(region: Region, regions: Region[]): RegionTree
  {
    try {
      return this.findChildrenOfLimit(region, regions, 100)
    } catch (error) {
      console.error("Could not derive region tree from regions response.")

      return {
        id: region.id,
        name: region.name,
        parentCount: region.parentCount,
        children: []
      }
    }
  }

  private findChildrenOfLimit(region: Region, regions: Region[], limit: number): RegionTree
  {
    if(limit <= 0)
      throw Error("Limit reached")

    let children = regions.filter(r => r.parent?.id == region.id)

    return {
      id: region.id,
      name: region.name,
      parentCount: region.parentCount,

      children: children.map(c => this.findChildrenOfLimit(c, regions, limit - 1))
    }
  }
  
}
