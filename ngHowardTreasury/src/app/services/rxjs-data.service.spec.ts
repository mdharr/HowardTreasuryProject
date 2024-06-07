import { TestBed } from '@angular/core/testing';

import { RxjsDataService } from './rxjs-data.service';

describe('RxjsDataService', () => {
  let service: RxjsDataService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RxjsDataService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
