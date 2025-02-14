import { Pipe, PipeTransform } from '@angular/core';
import { Resource } from '../../model/db/Resource';
import { DbId } from '../../model/db/dbDefs';
import { ResourceService } from './resource.service';

@Pipe({
  name: 'resource',
  standalone: true
})
export class ResourcePipe implements PipeTransform {

  constructor(
    private resources: ResourceService
  ) {}

  transform(res: Resource | DbId | undefined): string {
    return this.resources.getUrl(res)
  }

}
