import { Component, ElementRef, inject, OnDestroy, OnInit, ViewChild, AfterViewInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Person } from 'src/app/models/person';
import { AuthService } from 'src/app/services/auth.service';
import { PersonService } from 'src/app/services/person.service';

@Component({
  selector: 'app-characters',
  templateUrl: './characters.component.html',
  styleUrls: ['./characters.component.css']
})
export class CharactersComponent implements OnInit, OnDestroy {

  // properties initialization
  persons: Person[] = [];
  person: Person = new Person();

  // booleans
  isLoaded: boolean = false;

  // subscriptions declarations
  private personSubscription: Subscription | undefined;

  // view child
  @ViewChild('bgImage') bgImage!: ElementRef;

  backgroundImageUrl = 'https://reh.world/wp-content/uploads/2022/02/Kayanan-Howard-characters.png';

  // service injections
  auth = inject(AuthService);
  personService = inject(PersonService);

  ngOnInit(): void {

    this.personSubscription = this.personService.indexAll().subscribe({
      next: (data) => {
        this.persons = data;
        // this.isLoaded = true;
      },
      error:(fail) => {
        console.error('Error retrieving persons');
        console.error(fail);
      }
    });
  }

  ngOnDestroy(): void {
    if (this.personSubscription) {
      this.personSubscription.unsubscribe();
    }
  }

  imageLoaded() {
    // Set isLoaded to true when the image is loaded
    this.isLoaded = true;
  }
}
