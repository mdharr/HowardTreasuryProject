import { TestBed } from '@angular/core/testing';

import { StoryQuoteService } from './story-quote.service';

describe('StoryQuoteService', () => {
  let service: StoryQuoteService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(StoryQuoteService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
