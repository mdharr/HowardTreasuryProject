import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StoriesTestComponent } from './stories-test.component';

describe('StoriesTestComponent', () => {
  let component: StoriesTestComponent;
  let fixture: ComponentFixture<StoriesTestComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [StoriesTestComponent]
    });
    fixture = TestBed.createComponent(StoriesTestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
