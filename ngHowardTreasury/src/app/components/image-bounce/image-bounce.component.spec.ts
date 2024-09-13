import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImageBounceComponent } from './image-bounce.component';

describe('ImageBounceComponent', () => {
  let component: ImageBounceComponent;
  let fixture: ComponentFixture<ImageBounceComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ImageBounceComponent]
    });
    fixture = TestBed.createComponent(ImageBounceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
