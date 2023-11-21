import { ComponentFixture, TestBed } from '@angular/core/testing';

import { WeirdTalesComponent } from './weird-tales.component';

describe('WeirdTalesComponent', () => {
  let component: WeirdTalesComponent;
  let fixture: ComponentFixture<WeirdTalesComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [WeirdTalesComponent]
    });
    fixture = TestBed.createComponent(WeirdTalesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
