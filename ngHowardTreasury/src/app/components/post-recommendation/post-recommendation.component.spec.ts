import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PostRecommendationComponent } from './post-recommendation.component';

describe('PostRecommendationComponent', () => {
  let component: PostRecommendationComponent;
  let fixture: ComponentFixture<PostRecommendationComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [PostRecommendationComponent]
    });
    fixture = TestBed.createComponent(PostRecommendationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
