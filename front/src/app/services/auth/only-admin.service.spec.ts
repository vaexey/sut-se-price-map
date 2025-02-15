import { TestBed } from '@angular/core/testing';

import { OnlyAdminService } from './only-admin.service';

describe('OnlyAdminService', () => {
  let service: OnlyAdminService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(OnlyAdminService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
