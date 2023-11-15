import { trigger, transition, query, style, stagger, animate } from '@angular/animations';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { AuthService } from 'src/app/services/auth.service';
import { CollectionService } from 'src/app/services/collection.service';

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

  collections: Collection[] = [];
  loading: boolean = true;
  showAll: boolean = false;

  private collectionSubscription: Subscription | undefined;

  auth = inject(AuthService);
  collectionService = inject(CollectionService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToSubscriptions();

    this.triggerCustomEasingAnimation();
  }

  ngOnDestroy(): void {
    this.destroySubscriptions();
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
        next: (data) => {
          this.collections = data;
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
      this.showAll = true; // Set the showAll to true to trigger the animation
    }, 100);
  }

}
