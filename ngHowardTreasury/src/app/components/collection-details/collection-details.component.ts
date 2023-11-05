import { ActivatedRoute, ParamMap } from '@angular/router';
import { Component, Inject, inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';
import { CollectionService } from 'src/app/services/collection.service';
import { CollectionImage } from 'src/app/models/collection-image';
import { CollectionWithStoriesDTO } from 'src/app/models/collection-with-stories-dto';
import { DOCUMENT } from '@angular/common';

@Component({
  selector: 'app-collection-details',
  templateUrl: './collection-details.component.html',
  styleUrls: ['./collection-details.component.css']
})
export class CollectionDetailsComponent implements OnInit, OnDestroy {

  // property initialization
  collectionId: number = 0;
  collection: CollectionWithStoriesDTO = new CollectionWithStoriesDTO();
  collectionImages!: CollectionImage[];
  collectionDescription: string = '';

  // booleans
  isFullScreenImageVisible:boolean = false;
  isLoaded:boolean = false;
  loaded:boolean = false;

  // service injection
  auth = inject(AuthService);
  collectionService = inject(CollectionService);
  activatedRoute = inject(ActivatedRoute);
  renderer = inject(Renderer2);
  constructor(@Inject(DOCUMENT) private document: Document) {}

  // subscription declaration
  private paramsSubscription: Subscription | undefined;
  private collectionSubscription: Subscription | undefined;

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.getRouteParams();
    this.subscribeToCollectionService();
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
    console.log('ngAfterViewInit in PostRecommendationComponent');
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
      imgElement.src = this.collectionImages[0].imageUrl;
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
}
