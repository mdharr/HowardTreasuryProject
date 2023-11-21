import { TestBed } from '@angular/core/testing';

import { WeirdTalesService } from './weird-tales.service';

describe('WeirdTalesService', () => {
  let service: WeirdTalesService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(WeirdTalesService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
