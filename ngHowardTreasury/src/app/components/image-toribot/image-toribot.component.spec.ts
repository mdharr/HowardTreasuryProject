import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImageToribotComponent } from './image-toribot.component';

describe('ImageToribotComponent', () => {
  let component: ImageToribotComponent;
  let fixture: ComponentFixture<ImageToribotComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ImageToribotComponent]
    });
    fixture = TestBed.createComponent(ImageToribotComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
