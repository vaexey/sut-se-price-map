import { TestBed } from '@angular/core/testing';

import { ContribService } from './contrib.service';

describe('ContribService', () => {
  let service: ContribService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ContribService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
