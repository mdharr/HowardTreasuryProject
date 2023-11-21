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

  nextImage() {
    if (this.currentImageIndex < this.images.length - 1) {
      this.currentImageIndex++;
    } else {
      this.currentImageIndex = 0; // Loop back to the first image
    }
  }

  previousImage() {
    if (this.currentImageIndex > 0) {
      this.currentImageIndex--;
    } else {
      this.currentImageIndex = this.images.length - 1; // Loop back to the last image
    }
  }

  onSliderChange(event: any) {
    this.currentImageIndex = event.value;
  }

}
