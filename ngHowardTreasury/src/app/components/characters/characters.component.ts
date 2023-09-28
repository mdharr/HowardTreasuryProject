import { Component, inject, OnDestroy, OnInit } from '@angular/core';
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

  // subscriptions declarations
  private personSubscription: Subscription | undefined;

  // service injections
  auth = inject(AuthService);
  personService = inject(PersonService);

  ngOnInit(): void {

    this.personSubscription = this.personService.indexAll().subscribe({
      next: (data) => {
        this.persons = data;
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
}
