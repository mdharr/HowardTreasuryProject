import { trigger, transition, style, animate, group, query } from '@angular/animations';
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-image-carousel',
  templateUrl: './image-carousel.component.html',
  styleUrls: ['./image-carousel.component.css'],
  animations: [
    trigger('slideAnimation', [
      transition('* => next', [
        // Initial state for new image
        query(':enter', [
          style({ transform: 'translateX(100%)' }),
        ], { optional: true }),
        // Animating both, the new (:enter) and the current (:leave) image
        group([
          query(':leave', [
            animate('0.5s ease-out', style({ transform: 'translateX(-100%)' }))
          ], { optional: true }),
          query(':enter', [
            animate('0.5s ease-out', style({ transform: 'translateX(0)' }))
          ], { optional: true })
        ])
      ]),
      transition('* => prev', [
        query(':enter', [
          style({ transform: 'translateX(-100%)' }),
        ], { optional: true }),
        group([
          query(':leave', [
            animate('0.5s ease-out', style({ transform: 'translateX(100%)' }))
          ], { optional: true }),
          query(':enter', [
            animate('0.5s ease-out', style({ transform: 'translateX(0)' }))
          ], { optional: true })
        ])
      ])
    ])
  ]
})
export class ImageCarouselComponent {
  @Input() images: string[] = [];
  currentImageIndex = 0;
  prevImageIndex = -1;
  animationDirection: string = 'next';

  showNextImage() {
    this.prevImageIndex = this.currentImageIndex;
    this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
    this.animationDirection = 'next';
  }

  showPreviousImage() {
    this.prevImageIndex = this.currentImageIndex;
    this.currentImageIndex = (this.currentImageIndex - 1 + this.images.length) % this.images.length;
    this.animationDirection = 'prev';
  }
}
