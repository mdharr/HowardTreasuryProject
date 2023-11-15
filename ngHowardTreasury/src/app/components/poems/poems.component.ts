import { trigger, transition, query, style, stagger, animate } from '@angular/animations';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Poem } from 'src/app/models/poem';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { DialogService } from 'src/app/services/dialog.service';
import { PoemService } from 'src/app/services/poem.service';
import { SearchResultsService } from 'src/app/services/search-results.service';
import { SearchService } from 'src/app/services/search.service';

@Component({
  selector: 'app-poems',
  templateUrl: './poems.component.html',
  styleUrls: ['./poems.component.css'],
  animations: [
    trigger('customEasingAnimation', [
      transition(':enter', [
        query('.story-line', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(70, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ]
})
export class PoemsComponent implements OnInit, OnDestroy {

  // properties initialization
  poems: Poem[] = [];
  originalData: Poem[] = [];
  searchQuery: string = '';
  filteredPoems: Poem[] = [];
  cascadeDelay: number = 0;
  loggedInUser: User = new User();

  // booleans
  loading: boolean = false;
  sortTitleActive: boolean = false;
  sortFirstPublishedActive: boolean = false;
  filterCopyrightedActive: boolean = false;
  noMatches: boolean = false;
  showAll: boolean = false;

  // subscriptions declarations
  private poemSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;

  // service injections
  router = inject(Router);
  authService = inject(AuthService);
  poemService = inject(PoemService);
  dialogService = inject(DialogService);
  searchService = inject(SearchService);
  searchResultsService = inject(SearchResultsService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToLoggedInObservable();
    this.subscribeToPoemService();
    this.triggerCustomEasingAnimation();
  }

  ngOnDestroy(): void {
    this.destroySubscriptions();
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
    });
  }

  subscribeToPoemService = () => {
    this.poemSubscription = this.poemService.indexAll().subscribe({
      next: (data) => {
        this.poems = data;
        this.originalData = this.deepCopyArray(data);
        this.filteredPoems = data;
      },
      error:(fail) => {
        console.error('Error retrieving poems');
        console.error(fail);
      }
    });
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

  openLoginDialog() {
    this.dialogService.openLoginDialog();
  }

  destroySubscriptions = () => {
    if (this.poemSubscription) {
      this.poemSubscription.unsubscribe();
    }
    if (this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
  }

  sortPoemsByTitle(): void {
    this.filteredPoems = this.filteredPoems.sort((a, b) => a.title.localeCompare(b.title));
    this.sortTitleActive = true;
  }

  filterPoems(): void {
    this.noMatches = false;
    console.log(this.noMatches);

    if (this.searchQuery.trim() === '') {
      // If the search query is empty, reset to the current filtered data
      this.filteredPoems = [...this.originalData];
    } else {
      // Filter based on the current search query
      this.filteredPoems = this.originalData.filter(poem =>
        poem.title.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      if (this.filteredPoems.length === 0) {
        this.noMatches = true;
      }
    }
  }

  clearFilters(): void {
    // Reset all filters and restore the original data
    this.filteredPoems = [...this.originalData];
    this.poems = [...this.originalData];
    this.searchQuery = '';
    this.sortTitleActive = false;
    this.noMatches = false;
  }

  performSearch() {
    if (this.searchQuery) {
      this.searchService.search(this.searchQuery).subscribe((results) => {
        console.log('Search results from service:', results);
        // Update the search results in the shared service
        this.searchResultsService.updateSearchResults(results);
        this.router.navigate(['/search-results']);
      });
    }
  }

  openUserListDialog(poem: any) {
    this.dialogService.openUserListDialog(poem, 'poem');
  }

  deepCopyArray(arr: any[]): any[] {
    const copy = [];
    for (const item of arr) {
      if (typeof item === 'object' && item !== null) {
        if (Array.isArray(item)) {
          // If it's an array, recursively deep copy it
          copy.push(this.deepCopyArray(item));
        } else {
          // If it's an object, recursively deep copy it
          copy.push(this.deepCopyObject(item));
        }
      } else {
        // If it's a primitive value, simply assign it
        copy.push(item);
      }
    }
    return copy;
  }

    // Manually deep copy an object
    deepCopyObject(obj: { [key: string]: any }): { [key: string]: any } {
      const copy: { [key: string]: any } = {};
      for (const key in obj) {
        if (obj.hasOwnProperty(key)) {
          const value = obj[key];
          if (typeof value === 'object' && value !== null) {
            if (Array.isArray(value)) {
              // If it's an array, recursively deep copy it
              copy[key] = this.deepCopyArray(value);
            } else {
              // If it's an object, recursively deep copy it
              copy[key] = this.deepCopyObject(value);
            }
          } else {
            // If it's a primitive value, simply assign it
            copy[key] = value;
          }
        }
      }
      return copy;
    }

  triggerCustomEasingAnimation() {
    // You can use a timeout to trigger the animation after a short delay
    setTimeout(() => {
      this.showAll = true; // Set the showAll to true to trigger the animation
    }, 100);
  }
}
