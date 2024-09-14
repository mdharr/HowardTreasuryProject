import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImagePulseGlowComponent } from './image-pulse-glow.component';

describe('ImagePulseGlowComponent', () => {
  let component: ImagePulseGlowComponent;
  let fixture: ComponentFixture<ImagePulseGlowComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ImagePulseGlowComponent]
    });
    fixture = TestBed.createComponent(ImagePulseGlowComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
