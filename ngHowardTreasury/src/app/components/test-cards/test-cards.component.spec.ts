import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TestCardsComponent } from './test-cards.component';

describe('TestCardsComponent', () => {
  let component: TestCardsComponent;
  let fixture: ComponentFixture<TestCardsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [TestCardsComponent]
    });
    fixture = TestBed.createComponent(TestCardsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
