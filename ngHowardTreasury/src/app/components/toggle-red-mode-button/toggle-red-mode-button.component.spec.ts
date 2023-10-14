import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ToggleRedModeButtonComponent } from './toggle-red-mode-button.component';

describe('ToggleRedModeButtonComponent', () => {
  let component: ToggleRedModeButtonComponent;
  let fixture: ComponentFixture<ToggleRedModeButtonComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ToggleRedModeButtonComponent]
    });
    fixture = TestBed.createComponent(ToggleRedModeButtonComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
