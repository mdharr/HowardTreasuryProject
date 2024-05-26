import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StoryRecommendationComponent } from './story-recommendation.component';

describe('StoryRecommendationComponent', () => {
  let component: StoryRecommendationComponent;
  let fixture: ComponentFixture<StoryRecommendationComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [StoryRecommendationComponent]
    });
    fixture = TestBed.createComponent(StoryRecommendationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
