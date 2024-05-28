import { DOCUMENT } from '@angular/common';
import { Component, Inject, Input, OnInit, Renderer2, ViewChild, inject } from '@angular/core';
import { FullscreenImageComponent } from '../fullscreen-image/fullscreen-image.component';
import { FullscreenImageService } from 'src/app/services/fullscreen-image.service';

@Component({
  selector: 'app-image-carousel',
  templateUrl: './image-carousel.component.html',
  styleUrls: ['./image-carousel.component.css']
})
export class ImageCarouselComponent implements OnInit {
  @Input() images: string[] = [];
  currentImageIndex = 0;

  currentImageUrl!: string;

  @ViewChild('fullScreenImage') fullScreenImage!: FullscreenImageComponent;

  loading: boolean = false;
  isFullScreenImageVisible: boolean = false;
  fullImageLoaded: boolean = false;

  renderer = inject(Renderer2);
  fullscreenImageService = inject(FullscreenImageService);

  constructor(@Inject(DOCUMENT) private document: Document) {}

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

  // openFullScreenImage(imageUrl: string) {
  //   this.currentImageUrl = imageUrl;
  //   this.fullScreenImage.open();
  // }
  openFullScreenImage(imageUrl: string) {
    this.fullscreenImageService.open(imageUrl);
  }
}
