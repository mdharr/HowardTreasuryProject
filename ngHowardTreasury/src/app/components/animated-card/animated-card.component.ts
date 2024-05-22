import { Component, EventEmitter, Input, Output, OnInit, AfterViewInit } from '@angular/core';

@Component({
  selector: 'app-animated-card',
  templateUrl: './animated-card.component.html',
  styleUrls: ['./animated-card.component.css']
})
export class AnimatedCardComponent implements AfterViewInit {
  @Input() logoSrc: string = '';
  @Input() frontImageSrc: string = '';
  @Input() bgImageSrc: string = '';
  @Input() objectPosition: string = 'center';

  @Output() imagesLoaded: EventEmitter<void> = new EventEmitter<void>();

  isLoaded: boolean = false;

  ngAfterViewInit() {
    this.checkImagesLoaded();
  }

  checkImagesLoaded() {
    // Create an array of Image objects for the images you want to load
    // const imagesToLoad = [this.logoSrc, this.frontImageSrc, this.bgImageSrc];
    const imagesToLoad = [this.frontImageSrc, this.bgImageSrc];
    let loadedImages = 0;

    imagesToLoad.forEach((imageSrc) => {
      const image = new Image();
      image.src = imageSrc;

      image.onload = () => {
        loadedImages++;

        if (loadedImages === imagesToLoad.length) {
          this.isLoaded = true;
          this.imagesLoaded.emit();
        }
      };

      image.onerror = (error) => {
        console.error('Error loading image:', error);
      };
    });
  }

}
