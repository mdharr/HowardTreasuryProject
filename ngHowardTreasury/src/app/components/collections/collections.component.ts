import { trigger, transition, query, style, stagger, animate } from '@angular/animations';
import { Component, ElementRef, inject, OnDestroy, OnInit, QueryList, Renderer2, ViewChildren } from '@angular/core';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { AuthService } from 'src/app/services/auth.service';
import { CollectionService, Page } from 'src/app/services/collection.service';

@Component({
  selector: 'app-collections',
  templateUrl: './collections.component.html',
  styleUrls: ['./collections.component.css'],
  animations: [
    trigger('customEasingAnimation', [
      transition(':enter', [
        query('.book', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(50, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ]
})
export class CollectionsComponent implements OnInit, OnDestroy {

  @ViewChildren('collection') collectionElements!: QueryList<ElementRef>;

  collections: Collection[] = [];
  collectionsByTitleAsc: Collection[] = [];
  collectionsByTitleDesc: Collection[] = [];
  collectionsByDatePublishedAsc: Collection[] = [];
  collectionsByDatePublishedDesc: Collection[] = [];
  collectionsByRecommended: Collection[] = [];
  loading: boolean = true;
  showAll: boolean = false;
  showByCreatedAsc: boolean = false;
  showByCreatedDesc: boolean = false;
  showByTitleAsc: boolean = false;
  showByTitleDesc: boolean = false;
  showByRecommended: boolean = false;

  private collectionSubscription: Subscription | undefined;

  // observer
  private observer!: IntersectionObserver;

  auth = inject(AuthService);
  collectionService = inject(CollectionService);
  renderer = inject(Renderer2);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToSubscriptions();

    this.triggerCustomEasingAnimation();
  }

  ngOnDestroy(): void {
    this.destroySubscriptions();

    if (this.observer) {
      this.observer.disconnect();
    }
  }

  ngAfterViewInit() {
    // this.observer = new IntersectionObserver((entries) => {
    //   entries.forEach(entry => {
    //     if (entry.isIntersecting) {
    //       setTimeout(() => {
    //         this.renderer.addClass(entry.target, 'visible');
    //       }, 1000);
    //     }
    //   });
    // }, { threshold: 0.1 });

    // this.collectionElements.changes.subscribe((comps: QueryList<ElementRef>) => {
    //   comps.forEach(el => {
    //     this.observer.observe(el.nativeElement);
    //   });
    // });
  }

  delay(ms: number): Promise<void> {
    return new Promise<void>((resolve) => {
      setTimeout(() => {
        resolve();
      }, ms);
    });
  }

  subscribeToSubscriptions = () => {
    this.delay(250).then(() => {
      this.collectionSubscription = this.collectionService.indexAll().subscribe({
        next: (data: Collection[]) => {
          // this.collections = data;
          if (isPage<Collection>(data)) {
            this.collections = data.content;
          } else {
            this.collections = data;
            this.collectionsByDatePublishedAsc = this.sortByCreatedAsc(data);
            this.collectionsByDatePublishedDesc = this.sortByCreatedDesc(data);
            this.collectionsByTitleAsc = this.sortByTitleAsc(data);
            this.collectionsByTitleDesc = this.sortByTitleDesc(data);
            this.collectionsByRecommended = this.sortByRecommended(data);
            // console.log(this.collectionsByRecommended);
          }
          this.loading = false;
        },
        error: (fail) => {
          console.error('Error retrieving collections');
          console.error(fail);
          this.loading = false;
        }
      });
    });
  }

  destroySubscriptions = () => {
    if (this.collectionSubscription) {
      this.collectionSubscription.unsubscribe();
    }
  }

  triggerCustomEasingAnimation() {
    // You can use a timeout to trigger the animation after a short delay
    setTimeout(() => {
      this.showAll = false; // Set the showAll to true to trigger the animation
      this.showByRecommended = true;
    }, 100);
  }

  sortByCreatedAsc(collections: Collection[]) {
    return [...collections].sort((a, b) => new Date(a.publishedAt).getTime() - new Date(b.publishedAt).getTime());
  }

  sortByCreatedDesc(collections: Collection[]) {
    return [...collections].sort((a, b) => new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime());
  }

  sortByTitleAsc(collections: Collection[]) {
    return [...collections].sort((a, b) => a.title.localeCompare(b.title));
  }

  sortByTitleDesc(collections: Collection[]) {
    return [...collections].sort((a, b) => b.title.localeCompare(a.title));
  }

  sortByRecommended(collections: Collection[]) {
    return [...collections].filter(collection => collection.series);
  }

  toggleShowAll() {
    if(this.showAll) {
      this.showAll = false;
    }
    else {
      this.showAll = true;
    }
  }

  toggleDisplayOption(selectedOption: string) {
    // Reset all options to false
    this.showAll = false;
    this.showByCreatedAsc = false;
    this.showByCreatedDesc = false;
    this.showByTitleAsc = false;
    this.showByTitleDesc = false;
    this.showByRecommended = false;

    // Set the selected option to true
    switch (selectedOption) {
      case 'all':
        this.showAll = true;
        break;
      case 'created_asc':
        this.showByCreatedAsc = true;
        break;
      case 'created_desc':
        this.showByCreatedDesc = true;
        break;
      case 'title_asc':
        this.showByTitleAsc = true;
        break;
      case 'title_desc':
        this.showByTitleDesc = true;
        break;
      case 'recommended':
        this.showByRecommended = true;
        break;
      default:
        this.showAll = true;
        break;
    }
  }

}

function isPage<T>(data: any): data is Page<T> {
  return (data as Page<T>).content !== undefined;
}
