import { TestBed } from '@angular/core/testing';

import { GetParamService } from './get-param.service';

describe('GetParamService', () => {
  let service: GetParamService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(GetParamService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should return valid squashed request', () => {
    // const squashed = service.squashRequest({
    //   abc: 1,
    //   def: {
    //     ghi: 2,
    //     jkl: "3"
    //   }
    // })
  })
});
