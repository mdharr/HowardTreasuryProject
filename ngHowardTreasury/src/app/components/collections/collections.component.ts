import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { AuthService } from 'src/app/services/auth.service';
import { CollectionService } from 'src/app/services/collection.service';

@Component({
  selector: 'app-collections',
  templateUrl: './collections.component.html',
  styleUrls: ['./collections.component.css']
})
export class CollectionsComponent implements OnInit, OnDestroy {

  collections: Collection[] = [];
  loading: boolean = true;

  private collectionSubscription: Subscription | undefined;

  auth = inject(AuthService);
  collectionService = inject(CollectionService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToSubscriptions();
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

  // async loadImages(): Promise<void> {
  //   const imagePromises = this.collections.map((collection) => {
  //     const image = new Image();
  //     image.src = collection.collectionImages[0].thumbnailUrl;

  //     return new Promise<void>((resolve) => {
  //       image.onload = () => {
  //         collection.isLoadingImage = false;
  //         resolve();
  //       };
  //     });
  //   });
  //   await Promise.all(imagePromises);
  // }

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

}
