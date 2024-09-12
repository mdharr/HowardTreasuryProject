import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImageZoomComponent } from './image-zoom.component';

describe('ImageZoomComponent', () => {
  let component: ImageZoomComponent;
  let fixture: ComponentFixture<ImageZoomComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ImageZoomComponent]
    });
    fixture = TestBed.createComponent(ImageZoomComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
