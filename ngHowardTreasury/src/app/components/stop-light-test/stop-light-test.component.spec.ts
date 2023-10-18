import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StopLightTestComponent } from './stop-light-test.component';

describe('StopLightTestComponent', () => {
  let component: StopLightTestComponent;
  let fixture: ComponentFixture<StopLightTestComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [StopLightTestComponent]
    });
    fixture = TestBed.createComponent(StopLightTestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
