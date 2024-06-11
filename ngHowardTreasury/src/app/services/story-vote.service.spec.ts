import { TestBed } from '@angular/core/testing';

import { StoryVoteService } from './story-vote.service';

describe('StoryVoteService', () => {
  let service: StoryVoteService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(StoryVoteService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
