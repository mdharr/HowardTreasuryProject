import {
  ChangeDetectorRef,
  Component,
  ElementRef,
  inject,
  OnDestroy,
  OnInit,
  Renderer2,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Person } from 'src/app/models/person';
import { AuthService } from 'src/app/services/auth.service';
import { PersonService } from 'src/app/services/person.service';

@Component({
  selector: 'app-character-details',
  templateUrl: './character-details.component.html',
  styleUrls: ['./character-details.component.css'],
})
export class CharacterDetailsComponent implements OnInit, OnDestroy {
  // property initialization
  personId: number = 0;
  person: Person = new Person();
  personDescription: string = '';

  // booleans
  isLoaded = false;

  // service injection
  auth = inject(AuthService);
  personService = inject(PersonService);
  activatedRoute = inject(ActivatedRoute);
  renderer = inject(Renderer2);
  cdRef = inject(ChangeDetectorRef);

  // subscription declaration
  private paramsSubscription: Subscription | undefined;
  private personSubscription: Subscription | undefined;

  ngOnInit(): void {
    window.scrollTo(0, 0);
    setTimeout(() => {
      this.getRouteParams();

      this.subscribeToStoryService();
    }, 200);
  }

  ngOnDestroy(): void {
    this.destroySubscriptions();
  }

  ngAfterViewInit(): void {}

  getRouteParams = () => {
    this.paramsSubscription = this.activatedRoute.paramMap.subscribe(
      (params: ParamMap) => {
        let idString = params.get('characterId');
        if (idString) {
          this.personId = +idString;
        }
      }
    );
  };

  subscribeToStoryService = () => {
    this.personSubscription = this.personService.find(this.personId).subscribe({
      next: (data) => {
        this.person = data;
        // this.personDescription = this.createIlluminatedInitial(data.description);
        this.isLoaded = true;
      },
      error: (fail) => {
        console.error('Error getting person');
        console.error(fail);
      },
    });
  };

  destroySubscriptions = () => {
    if (this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }

    if (this.personSubscription) {
      this.personSubscription.unsubscribe();
    }
  };

  onImageLoad(): void {
    this.isLoaded = true;
  }
}
