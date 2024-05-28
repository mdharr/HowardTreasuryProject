import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-image-carousel',
  templateUrl: './image-carousel.component.html',
  styleUrls: ['./image-carousel.component.css']
})
export class ImageCarouselComponent implements OnInit {
  @Input() images: string[] = [];
  currentImageIndex = 0;

  loading: boolean = false;

  ngOnInit(): void {
    this.loadImage(this.images[this.currentImageIndex]);
  }

  showNextImage() {
    this.loading = true;
    this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
    this.loadImage(this.images[this.currentImageIndex]);
  }

  showPreviousImage() {
    this.loading = true;
    this.currentImageIndex = (this.currentImageIndex - 1 + this.images.length) % this.images.length;
    this.loadImage(this.images[this.currentImageIndex]);
  }

  loadImage(imageUrl: string) {
    const img = new Image();
    img.src = imageUrl;
    img.onload = () => {
      this.loading = false;
    };
  }
}
