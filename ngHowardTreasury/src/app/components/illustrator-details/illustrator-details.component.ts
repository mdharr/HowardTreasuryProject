import { Component, inject, OnInit, OnDestroy, AfterViewInit, HostListener, Renderer2, ElementRef } from '@angular/core';
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
  styleUrls: ['./illustrator-details.component.css']
})
export class IllustratorDetailsComponent implements OnInit, OnDestroy, AfterViewInit {
  // properties
  illustrator: Illustrator = new Illustrator();
  storyImages: StoryImage[] = [];
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
  isLoaded = false;
  imagesLoaded = false;

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

  ngOnInit() {
    window.scrollTo(0, 0);
    this.subscribeToServices();
  }

  ngOnDestroy() {
    this.destroySubscriptions();
  }

  ngAfterViewInit(): void {
    this.selectImage(this.currentIndex);
  }

  subscribeToServices = () => {
    this.getRouteParams();
    this.subscribeToAuth();
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

    setTimeout(() => {
      this.selectImage(this.currentIndex);
    }, 0);
  }

  selectImage(index: number) {
    this.currentIndex = index;
    this.selectedImage = this.storyImages[index];
    this.selectedThumbnailIndex = index;

    // Calculate the transform based on the selectedThumbnailIndex
    const thumbnailWidth = 50; // Adjust as needed
    const thumbnailsCount = this.storyImages.length;
    const containerWidth = thumbnailsCount * thumbnailWidth;
    const transform = containerWidth / 2 - this.selectedThumbnailIndex * thumbnailWidth;

    // Set the transform directly on the element
    const thumbnailsContainer = this.elementRef.nativeElement.querySelector('.thumbnails-container') as HTMLElement;
    if (thumbnailsContainer) {
      thumbnailsContainer.style.transform = `translateX(${transform}px)`;
    }
  }

  getThumbnailTransform(): string {
    // Return an empty string here since the transform is set in selectImage
    return '';
  }

  closeLightbox() {
    this.showLightbox = false;
  }

  nextImage() {
    this.currentIndex = (this.currentIndex + 1) % this.storyImages.length;
    this.selectedImage = this.storyImages[this.currentIndex];
  }

  prevImage() {
    this.currentIndex = (this.currentIndex - 1 + this.storyImages.length) % this.storyImages.length;
    this.selectedImage = this.storyImages[this.currentIndex];
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
    const lightboxWidth = window.innerWidth;

    if (clickX < lightboxWidth / 2) {
      // Clicked on the left half
      this.prevImage();
    } else {
      // Clicked on the right half
      this.nextImage();
    }
    this.selectImage(this.currentIndex);

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

  showMore() {
    this.maxImagesToShow += this.step;
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

}
