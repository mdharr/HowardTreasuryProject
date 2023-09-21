import { ActivatedRoute, ParamMap } from '@angular/router';
import { Component, inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { AuthService } from 'src/app/services/auth.service';
import { CollectionService } from 'src/app/services/collection.service';
import { CollectionImage } from 'src/app/models/collection-image';

@Component({
  selector: 'app-collection-details',
  templateUrl: './collection-details.component.html',
  styleUrls: ['./collection-details.component.css']
})
export class CollectionDetailsComponent implements OnInit, OnDestroy {

  // property initialization
  collectionId: number = 0;
  collection: Collection = new Collection();
  collectionImages!: CollectionImage[];

  // service injection
  auth = inject(AuthService);
  collectionService = inject(CollectionService);
  activatedRoute = inject(ActivatedRoute);
  renderer = inject(Renderer2);

  // subscription declaration
  private paramsSubscription: Subscription | undefined;
  private collectionSubscription: Subscription | undefined;

  ngOnInit(): void {
    this.getRouteParams();
    this.subscribeToCollectionServiceById();
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

  subscribeToCollectionServiceById = () => {
    this.collectionSubscription = this.collectionService.find(this.collectionId).subscribe({
      next: (data) => {
        this.collection = data;
        this.collectionImages = data.collectionImages;
      },
      error: (fail) => {
        console.error('Error getting collection');
        console.error(fail);
      }
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
}
