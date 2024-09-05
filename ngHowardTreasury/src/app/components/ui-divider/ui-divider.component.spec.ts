import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UiDividerComponent } from './ui-divider.component';

describe('UiDividerComponent', () => {
  let component: UiDividerComponent;
  let fixture: ComponentFixture<UiDividerComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [UiDividerComponent]
    });
    fixture = TestBed.createComponent(UiDividerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
