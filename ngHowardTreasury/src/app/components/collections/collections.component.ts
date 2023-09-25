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

    this.delay(250).then(() => {
      this.collectionSubscription = this.collectionService.indexAll().subscribe({
        next: (data) => {
          this.collections = data;
          this.loading = false; // Set loading to false when data is available
        },
        error: (fail) => {
          console.error('Error retrieving collections');
          console.error(fail);
          this.loading = false; // Set loading to false in case of an error
        }
      });
    });
  }

  ngOnDestroy(): void {
    if (this.collectionSubscription) {
      this.collectionSubscription.unsubscribe();
    }
  }

  delay(ms: number): Promise<void> {
    return new Promise<void>((resolve) => {
      setTimeout(() => {
        resolve();
      }, ms);
    });
  }

}
