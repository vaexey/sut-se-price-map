import { TestBed } from '@angular/core/testing';

import { OnlyAnonymousService } from './only-anonymous.service';

describe('OnlyAnonymousService', () => {
  let service: OnlyAnonymousService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(OnlyAnonymousService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
