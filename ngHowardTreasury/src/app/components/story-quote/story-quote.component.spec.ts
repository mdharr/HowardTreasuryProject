import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StoryQuoteComponent } from './story-quote.component';

describe('StoryQuoteComponent', () => {
  let component: StoryQuoteComponent;
  let fixture: ComponentFixture<StoryQuoteComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [StoryQuoteComponent]
    });
    fixture = TestBed.createComponent(StoryQuoteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
