import { CollectionService, Page } from './../../services/collection.service';
import { AfterViewInit, Component, Inject, inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { CollectionImage } from 'src/app/models/collection-image';
import { Poem } from 'src/app/models/poem';
import { AuthService } from 'src/app/services/auth.service';
import { PoemService } from 'src/app/services/poem.service';
import { DOCUMENT } from '@angular/common';

@Component({
  selector: 'app-poem-details',
  templateUrl: './poem-details.component.html',
  styleUrls: ['./poem-details.component.css']
})
export class PoemDetailsComponent implements OnInit, OnDestroy, AfterViewInit {
    // property initialization
    poemId: number = 0;
    poem: Poem = new Poem();
    poemExcerpt: string = '';
    poemCollections: Collection[] = [];
    first10Collections: Collection[] = [];
    collectionImage: CollectionImage = new CollectionImage();
    collections: Collection[] = [];

    // booleans
    isLoaded = false;

    // service injection
    auth = inject(AuthService);
    poemService = inject(PoemService);
    activatedRoute = inject(ActivatedRoute);
    renderer = inject(Renderer2);
    collectionService = inject(CollectionService);

    constructor(@Inject(DOCUMENT) private document: Document) {}

    // subscription declaration
    private paramsSubscription: Subscription | undefined;
    private poemSubscription: Subscription | undefined;
    private collectionsSubscription: Subscription | undefined;

    ngOnInit(): void {
      window.scrollTo(0, 0);
      setTimeout(() => {
        this.getRouteParams();
        this.subscribeToPoemService();
        this.subscribeToCollectionsService();
      }, 200);

    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    ngAfterViewInit(): void {

    }


    getRouteParams = () => {

      this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
        let idString = params.get('poemId');
        if(idString) {
          this.poemId = +idString;
        }
      });
    }

    subscribeToPoemService = () => {

      this.poemSubscription = this.poemService.find(this.poemId).subscribe({
        next: (data) => {
          this.poem = data;
          if(data.excerpt) {
            this.poemExcerpt = data.excerpt;
          }
          if(data.collections) {
            this.poemCollections = data.collections;
          }
          this.isLoaded = true;
        },
        error: (fail) => {
          console.error('Error getting story');
          console.error(fail);
        }
      });

      this.collectionsSubscription = this.poemService.findCollectionsByPoemId(this.poemId).subscribe({
        next: (data) => {
          this.poemCollections = data;
        },
        error: (fail) => {
          console.error('Error getting poem collections');
          console.error(fail);

        }
      });
    }

    subscribeToCollectionsService = () => {

      this.collectionsSubscription = this.collectionService.indexAll().subscribe({
        next: (data) => {
          if (isPage<Collection>(data)) {
            this.collections = data.content;
          } else {
            this.collections = data;
            this.first10Collections = this.takeFirst10Items(data);
            console.log('First ten collections: ', this.first10Collections);
          }
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

      if(this.poemSubscription) {
        this.poemSubscription.unsubscribe();
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

    takeFirst10Items(arr: Collection[]) {
      return arr.slice(0, 10);
    }
}

function isPage<T>(data: any): data is Page<T> {
  return (data as Page<T>).content !== undefined;
}
