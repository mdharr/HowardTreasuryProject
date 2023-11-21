import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-image-carousel',
  templateUrl: './image-carousel.component.html',
  styleUrls: ['./image-carousel.component.css']
})
export class ImageCarouselComponent {
  @Input() images: string[] = [];
  currentImageIndex = 0;

  showNextImage() {
    this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
  }

  showPreviousImage() {
    this.currentImageIndex = (this.currentImageIndex - 1 + this.images.length) % this.images.length;
  }
}
