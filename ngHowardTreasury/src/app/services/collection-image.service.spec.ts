import { TestBed } from '@angular/core/testing';

import { CollectionImageService } from './collection-image.service';

describe('CollectionImageService', () => {
  let service: CollectionImageService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CollectionImageService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
