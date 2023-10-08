import { CollectionImage } from './../../models/collection-image';
import { Component, inject, OnDestroy, OnInit, Renderer2, AfterViewInit, HostListener, ElementRef } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { Story } from 'src/app/models/story';
import { AuthService } from 'src/app/services/auth.service';
import { StoryService } from 'src/app/services/story.service';
import { StoryImage } from 'src/app/models/story-image';
import { CollectionService } from 'src/app/services/collection.service';

@Component({
  selector: 'app-story-details',
  templateUrl: './story-details.component.html',
  styleUrls: ['./story-details.component.css']
})
export class StoryDetailsComponent implements OnInit, OnDestroy, AfterViewInit {

    // property initialization
    storyId: number = 0;
    story: Story = new Story();
    storyExcerpt: string = '';
    storyCollections: Collection[] = [];
    storyImages: StoryImage[] = [];
    collections: Collection[] = [];
    collectionImage: CollectionImage = new CollectionImage();

    // lightbox properties
    showLightbox = false;
    selectedImage: any;
    currentIndex = 0;
    selectedThumbnailIndex = 0;
    centerOffset: number = 0;

    // booleans
    isLoaded = false;
    imagesLoaded = false;

    // service injection
    auth = inject(AuthService);
    storyService = inject(StoryService);
    collectionService = inject(CollectionService);
    activatedRoute = inject(ActivatedRoute);
    renderer = inject(Renderer2);
    elementRef = inject(ElementRef);

    // subscription declaration
    private paramsSubscription: Subscription | undefined;
    private storySubscription: Subscription | undefined;
    private collectionsSubscription: Subscription | undefined;

    ngOnInit(): void {
      setTimeout(() => {
        this.getRouteParams();

        this.subscribeToStoryServiceById();
        this.subscribeToCollectionsService();
      }, 200);

    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    ngAfterViewInit(): void {

      this.selectImage(this.currentIndex);
    }


    getRouteParams = () => {

      this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
        let idString = params.get('storyId');
        if(idString) {
          this.storyId = +idString;
        }
      });
    }

    subscribeToStoryServiceById = () => {

      this.storySubscription = this.storyService.find(this.storyId).subscribe({
        next: (data) => {
          this.story = data;
          if(data.excerpt) {
            this.storyExcerpt = data.excerpt;
          }
          if(data.collections) {
            this.storyCollections = data.collections;
          }
          if(data.storyImages) {
            this.storyImages = data.storyImages;
            this.imagesLoaded = true;
            // this.shuffleImages(this.storyImages);
          }
          this.isLoaded = true;
        },
        error: (fail) => {
          console.error('Error getting story');
          console.error(fail);
        }
      });
    }

    subscribeToCollectionsService = () => {

      this.collectionsSubscription = this.collectionService.indexAll().subscribe({
        next: (data) => {
          this.collections = data;
        },
        error: (fail) => {
          console.error('Error getting collections');
          console.error(fail);
        }
      });
    }

    destroySubscriptions = () => {
      if(this.paramsSubscription) {
        this.paramsSubscription.unsubscribe();
      }

      if(this.storySubscription) {
        this.storySubscription.unsubscribe();
      }

      if(this.collectionsSubscription) {
        this.collectionsSubscription.unsubscribe();
      }
    }

    createIlluminatedInitial = (text: string): string => {
      if (text.length === 0) {
        return '';
      }

      const firstLetter = text.charAt(0);
      const restOfString = text.slice(1);

      const illuminatedInitial = `<span class="first-letter">${firstLetter}</span>`;

      return illuminatedInitial + restOfString;
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

}
