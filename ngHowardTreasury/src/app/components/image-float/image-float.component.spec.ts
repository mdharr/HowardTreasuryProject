import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImageFloatComponent } from './image-float.component';

describe('ImageFloatComponent', () => {
  let component: ImageFloatComponent;
  let fixture: ComponentFixture<ImageFloatComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ImageFloatComponent]
    });
    fixture = TestBed.createComponent(ImageFloatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
