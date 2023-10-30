import { TestBed } from '@angular/core/testing';

import { ImageZoomService } from './image-zoom.service';

describe('ImageZoomService', () => {
  let service: ImageZoomService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ImageZoomService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
