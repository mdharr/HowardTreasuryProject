import { Component } from '@angular/core';

@Component({
  selector: 'app-squished-image',
  templateUrl: './squished-image.component.html',
  styleUrls: ['./squished-image.component.css']
})
export class SquishedImageComponent {

  images = [
    'https://images6.alphacoders.com/131/thumb-1920-1311862.jpeg',
    'https://images2.alphacoders.com/116/thumb-1920-1169015.jpg',
    'https://images5.alphacoders.com/130/thumb-1920-1301226.jpg',
    'https://images5.alphacoders.com/115/thumb-1920-1151243.jpg',
    'https://images3.alphacoders.com/115/thumb-1920-1151247.jpg'
  ];

  currentIndex = 0;

  distortImage(direction: string) {
    const currentImage = document.querySelector(`.slide:nth-child(${this.currentIndex + 1})`);
    let newIndex = this.currentIndex;

    if (direction === 'right') {
      newIndex = (this.currentIndex + 1) % this.images.length;
    } else if (direction === 'left') {
      newIndex = (this.currentIndex - 1 + this.images.length) % this.images.length;
    }

    this.applyTransition(currentImage, newIndex, direction);

    this.currentIndex = newIndex;
  }

  applyTransition(currentImage: Element | null, newIndex: number, direction: string) {
    const nextImage = document.querySelector(`.slide:nth-child(${newIndex + 1})`);
    if (currentImage && nextImage) {

      currentImage.classList.add('fade-out');
      currentImage.classList.remove('fade-in', 'visible');

      const allImages = document.querySelectorAll('.slide');
      allImages.forEach(img => {
        img.classList.remove('horizontal-distort-left', 'horizontal-distort-right');
      });

      nextImage.classList.remove('fade-out');
      nextImage.classList.add('visible', 'fade-in', direction === 'right' ? 'horizontal-distort-right' : 'horizontal-distort-left');

    }
  }
}
