import { ActivatedRoute, ParamMap } from '@angular/router';
import { Component, Inject, inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';
import { CollectionService } from 'src/app/services/collection.service';
import { CollectionImage } from 'src/app/models/collection-image';
import { CollectionWithStoriesDTO } from 'src/app/models/collection-with-stories-dto';
import { DOCUMENT } from '@angular/common';
import { trigger, transition, query, style, stagger, animate } from '@angular/animations';
import { FullscreenImageService } from 'src/app/services/fullscreen-image.service';

@Component({
  selector: 'app-collection-details',
  templateUrl: './collection-details.component.html',
  styleUrls: ['./collection-details.component.css'],
  animations: [
    trigger('customEasingAnimation', [
      transition(':enter', [
        query('.story-contents', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(100, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
        query('.poem-contents', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(100, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
        query('.miscellanea-contents', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(100, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ]
})
export class CollectionDetailsComponent implements OnInit, OnDestroy {

  // property initialization
  collectionId: number = 0;
  collection: CollectionWithStoriesDTO = new CollectionWithStoriesDTO();
  collectionImages!: CollectionImage[];
  collectionDescription: string = '';

  // booleans
  isFullScreenImageVisible: boolean = false;
  isLoaded: boolean = false;
  loaded: boolean = false;
  showAll: boolean = false;
  fullImageLoaded: boolean = false;

  // service injection
  auth = inject(AuthService);
  collectionService = inject(CollectionService);
  activatedRoute = inject(ActivatedRoute);
  renderer = inject(Renderer2);
  fullscreenImageService = inject(FullscreenImageService);
  constructor(@Inject(DOCUMENT) private document: Document) {}

  // subscription declaration
  private paramsSubscription: Subscription | undefined;
  private collectionSubscription: Subscription | undefined;

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.getRouteParams();
    this.subscribeToCollectionService();
    this.triggerCustomEasingAnimation();
  }

  ngOnDestroy(): void {
    this.destroySubscriptions();
  }

  getRouteParams = () => {
    this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
      let idString = params.get('collectionId');
      if(idString) {
        this.collectionId = +idString;
      }
    });
  }

  subscribeToCollectionService = () => {
    this.delay(250).then(() => {
      this.collectionSubscription = this.collectionService.findCollectionWithStoriesById((this.collectionId)).subscribe({
        next: (data) => {
          this.collection = data;
          this.sortByPageNumber();
          this.collectionImages = data.collectionImages;
          this.collectionDescription = data.description;
          this.isLoaded = true;
          this.checkImageLoaded();
        },
        error: (fail) => {
          console.error('Error getting collection');
          console.error(fail);
        }
      });
    });
  }

  destroySubscriptions = () => {
    if(this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }

    if(this.collectionSubscription) {
      this.collectionSubscription.unsubscribe();
    }
  }

  ngAfterViewInit() {
    this.checkImageLoaded();
  }

  checkImageLoaded() {
    if (this.collectionImages && this.collectionImages.length > 0) {
      const imgElement = new Image();
      imgElement.onload = () => {
        this.loaded = true;
      };
      imgElement.onerror = () => {
        this.loaded = false;
      };

      // Set the src property of the Image object to the image URL
      imgElement.src = this.collectionImages[0].thumbnailUrl;
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

  toggleFullScreenImage(): void {
    this.isFullScreenImageVisible = !this.isFullScreenImageVisible;

    if (this.isFullScreenImageVisible) {
      this.renderer.addClass(this.document.body, 'disable-scrolling');
    } else {
      this.renderer.removeClass(this.document.body, 'disable-scrolling');
    }
  }

  delay(ms: number): Promise<void> {
    return new Promise<void>((resolve) => {
      setTimeout(() => {
        resolve();
      }, ms);
    });
  }

  sortByPageNumber(): void {
    // Sort the stories within the collection by page number
    this.collection.stories.sort((a, b) => a.pageNumber - b.pageNumber);
    this.collection.poems.sort((a, b) => a.pageNumber - b.pageNumber);
    this.collection.miscellaneas.sort((a, b) => a.pageNumber - b.pageNumber);
  }

  triggerCustomEasingAnimation() {
    // You can use a timeout to trigger the animation after a short delay
    setTimeout(() => {
      this.showAll = true; // Set the showAll to true to trigger the animation
    }, 100);
  }

  onImageLoad() {
    this.fullImageLoaded = true;
  }

  openFullScreenImage(imageUrl: string) {
    this.fullscreenImageService.open(imageUrl);
  }
}
