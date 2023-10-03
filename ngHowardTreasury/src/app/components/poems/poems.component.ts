import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Poem } from 'src/app/models/poem';
import { AuthService } from 'src/app/services/auth.service';
import { PoemService } from 'src/app/services/poem.service';

@Component({
  selector: 'app-poems',
  templateUrl: './poems.component.html',
  styleUrls: ['./poems.component.css']
})
export class PoemsComponent implements OnInit, OnDestroy {

  // properties initialization
  poems: Poem[] = [];

  // subscriptions declarations
  private poemSubscription: Subscription | undefined;

  // service injections
  auth = inject(AuthService);
  poemService = inject(PoemService);

  ngOnInit(): void {
    this.subscribeToSubscriptions();

  }

  ngOnDestroy(): void {
    this.destroySubscriptions();

  }

  subscribeToSubscriptions = () => {
    this.poemSubscription = this.poemService.indexAll().subscribe({
      next: (data) => {
        this.poems = data;
      },
      error:(fail) => {
        console.error('Error retrieving poems');
        console.error(fail);
      }
    });
  }

  destroySubscriptions = () => {
    if (this.poemSubscription) {
      this.poemSubscription.unsubscribe();
    }
  }
}
