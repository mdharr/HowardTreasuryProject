import { TestBed } from '@angular/core/testing';

import { MiscellaneaService } from './miscellanea.service';

describe('MiscellaneaService', () => {
  let service: MiscellaneaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MiscellaneaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
