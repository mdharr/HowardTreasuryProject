import { Component, DebugElement } from '@angular/core';
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { ImageZoomDirective } from './image-zoom.directive';

// Create a test component to use the directive
@Component({
  template: '<div appImageZoom [imageSrc]="imageUrl"></div>',
})
class TestComponent {
  imageUrl = 'your-image-url.jpg';
}

describe('ImageZoomDirective', () => {
  let fixture: ComponentFixture<TestComponent>;
  let component: TestComponent;
  let directive: DebugElement;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [TestComponent, ImageZoomDirective],
    });

    fixture = TestBed.createComponent(TestComponent);
    component = fixture.componentInstance;
    directive = fixture.debugElement.query(By.directive(ImageZoomDirective));

    fixture.detectChanges();
  });

  it('should create an instance', () => {
    expect(directive).toBeTruthy();
  });
});
