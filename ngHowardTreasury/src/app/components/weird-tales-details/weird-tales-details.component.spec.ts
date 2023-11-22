import { ComponentFixture, TestBed } from '@angular/core/testing';

import { WeirdTalesDetailsComponent } from './weird-tales-details.component';

describe('WeirdTalesDetailsComponent', () => {
  let component: WeirdTalesDetailsComponent;
  let fixture: ComponentFixture<WeirdTalesDetailsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [WeirdTalesDetailsComponent]
    });
    fixture = TestBed.createComponent(WeirdTalesDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
