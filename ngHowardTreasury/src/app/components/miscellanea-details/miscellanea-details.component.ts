import { AfterViewInit, Component, inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { CollectionImage } from 'src/app/models/collection-image';
import { Miscellanea } from 'src/app/models/miscellanea';
import { AuthService } from 'src/app/services/auth.service';
import { MiscellaneaService } from 'src/app/services/miscellanea.service';

@Component({
  selector: 'app-miscellanea-details',
  templateUrl: './miscellanea-details.component.html',
  styleUrls: ['./miscellanea-details.component.css']
})
export class MiscellaneaDetailsComponent implements OnInit, OnDestroy, AfterViewInit {
    // property initialization
    miscellaneaId: number = 0;
    miscellanea: Miscellanea = new Miscellanea();
    miscellaneaExcerpt: string = '';
    miscellaneaCollections: Collection[] = [];
    collectionImage: CollectionImage = new CollectionImage();

    // booleans
    isLoaded = false;

    // service injection
    auth = inject(AuthService);
    miscellaneaService = inject(MiscellaneaService);
    activatedRoute = inject(ActivatedRoute);
    renderer = inject(Renderer2);

    // subscription declaration
    private paramsSubscription: Subscription | undefined;
    private miscellaneaSubscription: Subscription | undefined;
    private collectionsSubscription: Subscription | undefined;

    ngOnInit(): void {
      setTimeout(() => {
        this.getRouteParams();

        this.subscribeToMiscellaneaServiceById();
      }, 200);

    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    ngAfterViewInit(): void {

    }


    getRouteParams = () => {

      this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
        let idString = params.get('miscellaneaId');
        if(idString) {
          this.miscellaneaId = +idString;
        }
      });
    }

    subscribeToMiscellaneaServiceById = () => {

      this.miscellaneaSubscription = this.miscellaneaService.find(this.miscellaneaId).subscribe({
        next: (data) => {
          this.miscellanea = data;
          if(data.excerpt) {
            this.miscellaneaExcerpt = this.createIlluminatedInitial(data.excerpt);
          }
          if(data.collections) {
            this.miscellaneaCollections = data.collections;
          }
          this.isLoaded = true;
        },
        error: (fail) => {
          console.error('Error getting miscellanea');
          console.error(fail);
        }
      });

      this.collectionsSubscription = this.miscellaneaService.findCollectionsByMiscellaneaId(this.miscellaneaId).subscribe({
        next: (data) => {
          this.miscellaneaCollections = data;
        },
        error: (fail) => {
          console.error('Error getting miscellanea collections');
          console.error(fail);

        }
      });
    }

    destroySubscriptions = () => {
      if(this.paramsSubscription) {
        this.paramsSubscription.unsubscribe();
      }

      if(this.miscellaneaSubscription) {
        this.miscellaneaSubscription.unsubscribe();
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
}
