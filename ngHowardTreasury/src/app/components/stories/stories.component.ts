import { DialogService } from 'src/app/services/dialog.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Story } from 'src/app/models/story';
import { AuthService } from 'src/app/services/auth.service';
import { StoryService } from 'src/app/services/story.service';
import { User } from 'src/app/models/user';
import { SearchService } from 'src/app/services/search.service';
import { SearchResultsService } from 'src/app/services/search-results.service';
import { Router } from '@angular/router';
import { trigger, transition, query, style, stagger, animate } from '@angular/animations';

@Component({
  selector: 'app-stories',
  templateUrl: './stories.component.html',
  styleUrls: ['./stories.component.css'],
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
export class StoriesComponent implements OnInit, OnDestroy {

  // properties initialization
  loggedInUser: User = new User();
  originalData: Story[] = [];
  stories: Story[] = [];
  searchQuery: string = '';
  filteredStories: Story[] = [];
  cascadeDelay: number = 0;


  // booleans
  loading: boolean = false;
  sortTitleActive: boolean = false;
  sortFirstPublishedActive: boolean = false;
  filterCopyrightedActive: boolean = false;
  noMatches: boolean = false;
  showAll: boolean = false;

  // subscriptions declarations
  private storySubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;

  // service injections
  router = inject(Router);
  authService = inject(AuthService);
  storyService = inject(StoryService);
  dialogService = inject(DialogService);
  searchService = inject(SearchService);
  searchResultsService = inject(SearchResultsService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToLoggedInObservable();
    this.subscribeToStoryService();
    this.triggerCustomEasingAnimation();
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
    });
  }

  subscribeToStoryService = () => {
    this.storySubscription = this.storyService.indexAll().subscribe({
      next: (data) => {
        this.stories = data;
        this.originalData = this.deepCopyArray(data);
        this.filteredStories = data;
      },
      error:(fail) => {
        console.error('Error retrieving stories');
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

  ngOnDestroy(): void {
    if (this.storySubscription) {
      this.storySubscription.unsubscribe();
    }
    if (this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
  }

  sortStoriesByTitle(): void {
    this.filteredStories = this.filteredStories.sort((a, b) => a.title.localeCompare(b.title));
    this.sortTitleActive = true;
    this.sortFirstPublishedActive = false;
  }

  sortStoriesByFirstPublished(): void {
    this.filteredStories = this.filteredStories.sort((a, b) => new Date(a.firstPublished).getTime() - new Date(b.firstPublished).getTime());
    this.sortFirstPublishedActive = true;
    this.sortTitleActive = false;
  }

  filterByCopyrighted(): void {
    this.filteredStories = this.filteredStories.filter(story => !story.isCopyrighted);
    this.filterCopyrightedActive = true;
  }


  filterStories(): void {
    this.noMatches = false;
    console.log(this.noMatches);

    if (this.searchQuery.trim() === '') {
      // If the search query is empty, reset to the current filtered data
      this.filteredStories = [...this.originalData];
      // Reapply filters if active
      if (this.filterCopyrightedActive) {
        this.filteredStories = this.filteredStories.filter(story => !story.isCopyrighted);
      }
    } else {
      // Filter based on the current search query
      this.filteredStories = this.originalData.filter(story =>
        story.title.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      if (this.filteredStories.length === 0) {
        this.noMatches = true;
      }
      // Reapply filters if active
      if (this.filterCopyrightedActive) {
        this.filteredStories = this.filteredStories.filter(story => !story.isCopyrighted);
      }
    }
  }

  clearFilters(): void {
    // Reset all filters and restore the original data
    this.filteredStories = [...this.originalData];
    this.stories = [...this.originalData];
    this.searchQuery = '';
    this.sortTitleActive = false;
    this.sortFirstPublishedActive = false;
    this.filterCopyrightedActive = false;
    this.noMatches = false;
  }

  performSearch() {
    if (this.searchQuery) {
      this.searchService.search(this.searchQuery).subscribe((results) => {
        console.log('Search results from service:', results);
        // Update the search results in the shared service
        this.searchResultsService.updateSearchResults(results);
        this.router.navigate(['/search-results']);

        // this.searchQuery = '';
      });
    }
  }

  openUserListDialog(story: any) {
    this.dialogService.openUserListDialog(story, 'story');
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
