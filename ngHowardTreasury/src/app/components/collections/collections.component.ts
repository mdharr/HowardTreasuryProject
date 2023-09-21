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

  private collectionSubscription: Subscription | undefined;

  auth = inject(AuthService);
  collectionService = inject(CollectionService);

  ngOnInit(): void {

    this.collectionSubscription = this.collectionService.indexAll().subscribe({
      next: (data) => {
        this.collections = data;
      },
      error:(fail) => {
        console.error('Error retrieving collections');
        console.error(fail);
      }
    });
  }
  ngOnDestroy(): void {
    if (this.collectionSubscription) {
      this.collectionSubscription.unsubscribe();
    }
  }


}
