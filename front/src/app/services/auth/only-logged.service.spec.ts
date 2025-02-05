import { TestBed } from '@angular/core/testing';

import { OnlyLoggedService } from './only-logged.service';

describe('OnlyLoggedService', () => {
  let service: OnlyLoggedService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(OnlyLoggedService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
