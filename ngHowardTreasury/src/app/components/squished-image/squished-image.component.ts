import { style } from '@angular/animations';
import { AfterViewInit, Component, ElementRef, HostListener, ViewChild } from '@angular/core';

@Component({
  selector: 'app-squished-image',
  templateUrl: './squished-image.component.html',
  styleUrls: ['./squished-image.component.css']
})
export class SquishedImageComponent implements AfterViewInit {

  @ViewChild('sliderContainer') sliderContainer!: ElementRef;
  @ViewChild('sliderBar') sliderBar!: ElementRef;
  @ViewChild('leftImage') leftImage!: ElementRef;

  private isDragging = false;

  images = [
    'https://images6.alphacoders.com/131/thumb-1920-1311862.jpeg',
    'https://images2.alphacoders.com/116/thumb-1920-1169015.jpg',
    'https://images5.alphacoders.com/130/thumb-1920-1301226.jpg',
    'https://images5.alphacoders.com/115/thumb-1920-1151243.jpg',
    'https://images3.alphacoders.com/115/thumb-1920-1151247.jpg',
    'https://images2.alphacoders.com/121/thumb-1920-1214928.png',
    'https://images7.alphacoders.com/116/thumb-1920-1169013.jpg',
    'https://images3.alphacoders.com/121/thumb-1920-1216464.jpg',
    'https://images6.alphacoders.com/121/thumb-1920-1214923.png',
    'https://images2.alphacoders.com/135/thumb-1920-1353167.png',
    'https://images.alphacoders.com/135/thumb-1920-1353166.png',
  ];

  currentIndex = 0;

  ngAfterViewInit() {
    this.sliderBar.nativeElement.addEventListener('mousedown', this.onDragStart.bind(this));
  }

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

  showArrows() {
    const nextBtn = document.querySelector('.next') as HTMLButtonElement;
    const prevBtn = document.querySelector('.prev') as HTMLButtonElement;

    if (nextBtn && prevBtn) {
      nextBtn.style.opacity = '1';
      prevBtn.style.opacity = '1';
    }
  }

  hideArrows() {
    const nextBtn = document.querySelector('.next') as HTMLButtonElement;
    const prevBtn = document.querySelector('.prev') as HTMLButtonElement;

    if (nextBtn && prevBtn) {
      nextBtn.style.opacity = '0';
      prevBtn.style.opacity = '0';
    }
  }




  @HostListener('window:mousemove', ['$event'])
  onDrag(event: MouseEvent) {
    if (!this.isDragging) return;

    const rect = this.sliderContainer.nativeElement.getBoundingClientRect();
    const offsetX = event.clientX - rect.left;

    if (offsetX < 0 || offsetX > rect.width) return;

    const sliderPosition = (offsetX / rect.width) * 100;
    this.sliderBar.nativeElement.style.left = `${sliderPosition + 0.09}%`;

    this.leftImage.nativeElement.style.clipPath = `inset(0 ${100 - sliderPosition}% 0 0)`;
  }

  @HostListener('window:mouseup')
  stopDrag() {
    this.isDragging = false;
  }

  private onDragStart() {
    this.isDragging = true;
  }

  showDragBar() {
    const containerDiv = document.querySelector('.comparison-slider') as HTMLDivElement;
    const dragBarElement = document.querySelector('.slider-bar') as HTMLDivElement;

    if (containerDiv && dragBarElement) {
      dragBarElement.style.zIndex = '1';
    }
  }

  hideDragBar() {
    const containerDiv = document.querySelector('.comparison-slider') as HTMLDivElement;
    const dragBarElement = document.querySelector('.slider-bar') as HTMLDivElement;

    if (containerDiv && dragBarElement) {
      dragBarElement.style.zIndex = '-1';
    }
  }
}
