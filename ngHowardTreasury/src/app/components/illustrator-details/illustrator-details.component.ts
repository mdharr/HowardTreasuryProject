import { trigger, transition, query, style, stagger, animate, AnimationBuilder } from '@angular/animations';
import { DOCUMENT } from '@angular/common';
import { Component, inject, OnInit, OnDestroy, AfterViewInit, HostListener, Renderer2, ElementRef, Inject, ViewChild } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Illustrator } from 'src/app/models/illustrator';
import { StoryImage } from 'src/app/models/story-image';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { IllustratorService } from 'src/app/services/illustrator.service';

@Component({
  selector: 'app-illustrator-details',
  templateUrl: './illustrator-details.component.html',
  styleUrls: ['./illustrator-details.component.css'],
  animations: [
    trigger('customEasingAnimation', [
      transition(':enter', [
        query('.image-item', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(50, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ]
})
export class IllustratorDetailsComponent implements OnInit, OnDestroy, AfterViewInit {

  // @ViewChild('sheenBox', { static: false }) sheenBoxRef: ElementRef | undefined;

  // properties
  illustrator: Illustrator = new Illustrator();
  storyImages: StoryImage[] = [];
  imageUrls: string[] = [];
  displayedImages: StoryImage[] = [];
  loggedInUser: User = new User();
  illustratorId: number = 0;

  // show more feature
  maxImagesToShow = 14;
  step = 14;

  // lightbox properties
  showLightbox = false;
  selectedImage: any;
  currentIndex = 0;
  selectedThumbnailIndex = 0;
  centerOffset: number = 0;

  // booleans
  isLoaded: boolean = false;
  imagesLoaded: boolean = false;
  showAll: boolean = false;

  // subscriptions
  private authSubscription: Subscription | undefined;
  private illustratorSubscription: Subscription | undefined;
  private paramsSubscription: Subscription | undefined;

  // service injections
  authService = inject(AuthService);
  illustratorService = inject(IllustratorService);
  activatedRoute = inject(ActivatedRoute);
  renderer = inject(Renderer2);
  elementRef = inject(ElementRef);
  animationBuilder = inject(AnimationBuilder);
  constructor(@Inject(DOCUMENT) private document: Document) {}

  ngOnInit() {
    window.scrollTo(0, 0);
    this.subscribeToServices();
    this.triggerCustomEasingAnimation();

  }

  ngOnDestroy() {
    this.destroySubscriptions();
  }

  ngAfterViewInit(): void {
    if (this.storyImages && this.storyImages.length > 0) {
      this.selectImage(this.currentIndex);
    }
    // Mark initial images as animated
    const initialImageElements = this.elementRef.nativeElement.querySelectorAll('.image-item');
    initialImageElements.forEach((el: Element) => {
      el.classList.add('animated');
    });
  }

  subscribeToServices = () => {
    this.getRouteParams();
    this.subscribeToIllustrators();
  }

  destroySubscriptions = () => {
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
    if(this.illustratorSubscription) {
      this.illustratorSubscription.unsubscribe();
    }
    if(this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
  }

  getRouteParams = () => {
    this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
      let idString = params.get('illustratorId');
      if(idString) {
        this.illustratorId = +idString;
      }
    });
  }

  subscribeToAuth = () => {
    this.authSubscription = this.authService.getLoggedInUser().subscribe((user: User) => {
      this.loggedInUser = user;
    });
  }

  subscribeToIllustrators = () => {
    this.illustratorSubscription = this.illustratorService.find(this.illustratorId).subscribe({
      next: (data) => {
        this.illustrator = data;
        this.storyImages = data.storyImages;
        this.imageUrls = data.storyImages.map(item => item.imageUrl);
        this.displayedImages = this.storyImages.slice(0, this.maxImagesToShow).map(image => ({ ...image, ready: true }));

      },
      error: (fail) => {
        console.error('Error retrieving illustrators');
        console.error(fail);
      }
    });
  }

  shuffleImages = (storyImages: StoryImage[]) => {
    for (let i = storyImages.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [storyImages[i], storyImages[j]] = [storyImages[j], storyImages[i]];
    }
  }

  openLightbox(index: number, event: MouseEvent) {
    event.stopPropagation();
    this.showLightbox = true;
    this.selectedImage = this.storyImages[index];
    this.selectedThumbnailIndex = index;
    this.currentIndex = index;
    if (this.showLightbox) {
      this.renderer.addClass(this.document.body, 'disable-scrolling');
    }

    setTimeout(() => {
      this.selectImage(this.currentIndex);
    }, 0);
  }


  async selectImage(index: number, isInitialLoad: boolean = false) {
    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    // Immediately set opacity to 1 for initial load
    if (isInitialLoad) {
      currentImageElement.style.opacity = '1';
    } else if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    // Wait for the new image size calculation
    const newImageSize = await this.calculateNewImageSize(this.storyImages[index].imageUrl);

    setTimeout(() => {
      // Update the selected image
      this.currentIndex = index;
      this.selectedImage = this.storyImages[index];
      this.selectedThumbnailIndex = index;
      this.updateThumbnailPosition();

      // Apply the new size to the container
      const container = this.document.querySelector('.lightbox-image-container') as HTMLElement;
      if (container) {
        if (isInitialLoad) {
          // For initial load, remove the transition class after setting the size
          container.style.width = `${newImageSize.width}px`;
          container.style.height = `${newImageSize.height}px`;
          container.classList.remove('no-transition');
        } else {
          // For subsequent loads, ensure the transition class is not present
          container.style.width = `${newImageSize.width}px`;
          container.style.height = `${newImageSize.height}px`;
        }
      }

      // Fade in the new image after the container resizing
      setTimeout(() => {
        if (currentImageElement) {
          currentImageElement.style.opacity = '1';
        }
      }, 500);
    }, 500);
  }



  private calculateNewImageSize(imageUrl: string): Promise<{ width: number, height: number }> {
    return new Promise((resolve, reject) => {
      const img = new Image();

      img.onload = () => {
        const maxWidth = window.innerWidth * 0.9; // 90% of the window width
        const maxHeight = window.innerHeight * 0.7; // 80% of the window height

        // Original dimensions
        const originalWidth = img.naturalWidth;
        const originalHeight = img.naturalHeight;

        // Check if the image needs resizing
        if (originalWidth <= maxWidth && originalHeight <= maxHeight) {
          resolve({ width: originalWidth, height: originalHeight });
          return;
        }

        // Calculate aspect ratio
        const aspectRatio = originalWidth / originalHeight;

        // Calculate new dimensions while maintaining aspect ratio
        let newWidth = maxWidth;
        let newHeight = newWidth / aspectRatio;

        if (newHeight > maxHeight) {
          newHeight = maxHeight;
          newWidth = newHeight * aspectRatio;
        }

        resolve({ width: newWidth, height: newHeight });
      };

      img.onerror = () => {
        reject('Could not load image');
      };

      img.src = imageUrl; // Set the source of the image
    });
  }

  getThumbnailTransform(): string {
    if (!this.storyImages.length) return '';

    const thumbnailWidth = 50; // Width of each thumbnail
    const gapBetweenThumbnails = 10; // Adjust if there's a gap between thumbnails
    const effectiveThumbnailWidth = thumbnailWidth + gapBetweenThumbnails; // Total space taken by each thumbnail including gap

    // Calculate the position of the center of the selected thumbnail
    const selectedThumbnailCenter = this.selectedThumbnailIndex * effectiveThumbnailWidth + thumbnailWidth / 2;

    // Calculate the center of the thumbnails container
    const containerCenter = window.innerWidth / 2;

    // Calculate the transform value
    const transformValue = containerCenter - selectedThumbnailCenter;

    return `translateX(${transformValue}px)`;
  }


  private updateThumbnailPosition() {
    const thumbnailWidth = 50; // Adjust as needed
    const thumbnailsCount = this.storyImages.length;
    const containerWidth = thumbnailsCount * thumbnailWidth;
    const transform = containerWidth / 2 - this.selectedThumbnailIndex * thumbnailWidth;

    const thumbnailsContainer = this.elementRef.nativeElement.querySelector('.thumbnails-container') as HTMLElement;
    if (thumbnailsContainer) {
      thumbnailsContainer.style.transform = `translateX(${transform}px)`;
    }
  }

  closeLightbox() {
    this.showLightbox = false;
    this.renderer.removeClass(this.document.body, 'disable-scrolling');
  }

  nextImage() {
    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    setTimeout(() => {
      this.currentIndex = (this.currentIndex + 1) % this.storyImages.length;
      this.selectImage(this.currentIndex);
    }, 0); // Match the duration of the fade-out transition
  }

  prevImage() {
    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    setTimeout(() => {
      this.currentIndex = (this.currentIndex - 1 + this.storyImages.length) % this.storyImages.length;
      this.selectImage(this.currentIndex);
    }, 0); // Match the duration of the fade-out transition
  }


  downloadImage(image: any) {
    // Replace 'image.blobUrl' with the actual property that stores the image URL.
    const downloadLink = document.createElement('a');
    downloadLink.href = image.textUrl;
    downloadLink.download = 'image.jpg'; // Set the desired file name.
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
  }

  onLightboxImageClick(event: MouseEvent) {
    const clickX = event.clientX;
    const lightboxImageElement = event.target as HTMLElement;
    const lightboxImageRect = lightboxImageElement.getBoundingClientRect();
    const lightboxImageWidth = lightboxImageRect.width;

    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    setTimeout(() => {
      if (clickX < lightboxImageRect.left + lightboxImageWidth / 2) {
        // Clicked on the left half
        this.prevImage();
      } else {
        // Clicked on the right half
        this.nextImage();
      }
    }, 0); // Match the duration of the fade-out transition
  }

  @HostListener('document:keydown', ['$event'])
  handleKeyboardEvent(event: KeyboardEvent) {
    if (this.showLightbox) {
      if (event.code === 'ArrowRight') {
        this.nextImage();
      } else if (event.code === 'ArrowLeft') {
        this.prevImage();
      } else if (event.code === 'Escape') {
        this.closeLightbox();
      }
    }
  }

  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent) {
    if (this.showLightbox) {
      const lightboxContent = this.elementRef.nativeElement.querySelector('.lightbox-content');
      const lightboxImages = this.elementRef.nativeElement.querySelectorAll('.lightbox-image');

      // Check if the clicked element is outside the lightbox content
      if (lightboxContent && !lightboxContent.contains(event.target)) {
        // Check if the clicked element is any of the lightbox images
        let clickedOnLightboxImage = false;
        lightboxImages.forEach((image: HTMLElement) => {
          if (image.contains(event.target as Node)) {
            clickedOnLightboxImage = true;
            return;
          }
        });

        if (!clickedOnLightboxImage) {
          this.closeLightbox();
        }
      }
    }
  }

  getLightboxBackgroundStyle(): any {
    if (this.selectedImage) {
      const backgroundImage = `url(${this.selectedImage.imageUrl})`;
      const filterProperties = 'blur(20px) brightness(50%)';
      return {
        'background-image': backgroundImage,
        'background-size': 'cover', // Set the background size to cover
        filter: filterProperties,
        position: 'fixed',
        top: '-50px',
        left: '-50px',
        width: '120%',
        height: '120%',
        zIndex: '1',
        boxShadow: 'inset 0 0 10em 15em rgba(0, 0, 0, 0.5)'
      };
    } else {
      return {};
    }
  }

  getLightboxThumbnailStyle(index: number): any {
    if (this.selectedImage && index === this.selectedThumbnailIndex) {
      const border = '2px solid var(--red_color)';
      return {
        border: border,
        transition: 'border 0.2s'
      };
    } else {
      return {};
    }
  }

  triggerCustomEasingAnimation() {
    setTimeout(() => {
      this.showAll = true;
    }, 100);
  }

  showMore() {
    const newMax = this.maxImagesToShow + this.step;
    const newImages = this.storyImages.slice(this.maxImagesToShow, newMax);

    newImages.forEach(image => image.ready = false); // Mark new images as not ready
    this.displayedImages = [...this.displayedImages, ...newImages]; // Add new images to the displayed array
    this.maxImagesToShow = newMax; // Update max images to show

    // Animate new images
    setTimeout(() => this.animateNewImages(newImages), 0);
  }

  animateNewImages(newImages: StoryImage[]) {
    newImages.forEach((image, index) => {
      setTimeout(() => {
        image.ready = true;
        this.animateImage(image.id);
      }, index * 50); // Use the same 50ms stagger as in customEasingAnimation
    });
  }

  animateImage(imageId: number) {
    const imageElement = this.elementRef.nativeElement.querySelector(`.image-item[data-id="${imageId}"]`);
    if (imageElement && !imageElement.classList.contains('animated')) {
      const animation = this.animationBuilder.build([
        style({ opacity: 0, transform: 'translateY(20px)' }),
        animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' }))
      ]);
      const player = animation.create(imageElement);
      player.play();
      imageElement.classList.add('animated');
    }
  }

  // toggleGlassEffect(): void {
  //   if (this.sheenBoxRef && this.sheenBoxRef.nativeElement) {
  //     const sheenBox = this.sheenBoxRef.nativeElement;
  //     if (sheenBox.classList.contains('glass')) {
  //       this.renderer.removeClass(sheenBox, 'glass');
  //       setTimeout(() => this.renderer.addClass(sheenBox, 'glass'), 10);
  //     } else {
  //       this.renderer.addClass(sheenBox, 'glass');
  //     }
  //   }
  // }
}
