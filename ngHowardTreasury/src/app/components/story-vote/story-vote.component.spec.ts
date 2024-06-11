import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StoryVoteComponent } from './story-vote.component';

describe('StoryVoteComponent', () => {
  let component: StoryVoteComponent;
  let fixture: ComponentFixture<StoryVoteComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [StoryVoteComponent]
    });
    fixture = TestBed.createComponent(StoryVoteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
