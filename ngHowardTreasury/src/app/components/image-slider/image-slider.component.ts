import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-image-slider',
  templateUrl: './image-slider.component.html',
  styleUrls: ['./image-slider.component.css']
})
export class ImageSliderComponent {

  @Input() images: any[] = [];
  currentImageIndex = 0;

  get currentImage() {
    return this.images[this.currentImageIndex];
  }
}
