import { Component, inject, Renderer2 } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Person } from 'src/app/models/person';
import { AuthService } from 'src/app/services/auth.service';
import { PersonService } from 'src/app/services/person.service';

@Component({
  selector: 'app-character-details',
  templateUrl: './character-details.component.html',
  styleUrls: ['./character-details.component.css']
})
export class CharacterDetailsComponent {

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

      // subscription declaration
      private paramsSubscription: Subscription | undefined;
      private personSubscription: Subscription | undefined;

      ngOnInit(): void {
        setTimeout(() => {
          this.getRouteParams();

          this.subscribeToStoryServiceById();
        }, 200);

      }

      ngOnDestroy(): void {
        this.destroySubscriptions();
      }

      ngAfterViewInit(): void {

      }


      getRouteParams = () => {

        this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
          let idString = params.get('characterId');
          if(idString) {
            this.personId = +idString;
          }
        });
      }

      subscribeToStoryServiceById = () => {

        this.personSubscription = this.personService.find(this.personId).subscribe({
          next: (data) => {
            this.person = data;
            // this.personDescription = this.createIlluminatedInitial(data.description);
            this.isLoaded = true;
          },
          error: (fail) => {
            console.error('Error getting person');
            console.error(fail);
          }
        });
      }

      destroySubscriptions = () => {
        if(this.paramsSubscription) {
          this.paramsSubscription.unsubscribe();
        }

        if(this.personSubscription) {
          this.personSubscription.unsubscribe();
        }
      }
}
