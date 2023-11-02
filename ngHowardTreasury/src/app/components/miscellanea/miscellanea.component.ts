import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Miscellanea } from 'src/app/models/miscellanea';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { DialogService } from 'src/app/services/dialog.service';
import { MiscellaneaService } from 'src/app/services/miscellanea.service';
import { SearchResultsService } from 'src/app/services/search-results.service';
import { SearchService } from 'src/app/services/search.service';

@Component({
  selector: 'app-miscellanea',
  templateUrl: './miscellanea.component.html',
  styleUrls: ['./miscellanea.component.css']
})
export class MiscellaneaComponent implements OnInit, OnDestroy {

    // properties initialization
    miscellaneas: Miscellanea[] = [];
    originalData: Miscellanea[] = [];
    searchQuery: string = '';
    filteredMiscellaneas: Miscellanea[] = [];
    cascadeDelay: number = 0;
    loggedInUser: User = new User();

    // booleans
    loading: boolean = false;
    sortTitleActive: boolean = false;
    sortFirstPublishedActive: boolean = false;
    filterCopyrightedActive: boolean = false;
    noMatches: boolean = false;

    // subscriptions declarations
    private miscellaneaSubscription: Subscription | undefined;
    private loggedInSubscription: Subscription | undefined;

    // service injections
    miscellaneaService = inject(MiscellaneaService);
    router = inject(Router);
    authService = inject(AuthService);
    dialogService = inject(DialogService);
    searchService = inject(SearchService);
    searchResultsService = inject(SearchResultsService);

    ngOnInit(): void {
      window.scrollTo(0, 0);
      this.subscribeToLoggedInObservable();
      this.subscribeToMiscellaneaService();
    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    subscribeToLoggedInObservable() {
      this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
        this.loggedInUser = user;
      });
    }

    subscribeToMiscellaneaService = () => {
      this.miscellaneaSubscription = this.miscellaneaService.indexAll().subscribe({
        next: (data) => {
          this.miscellaneas = data;
          this.originalData = this.deepCopyArray(data);
          this.filteredMiscellaneas = data;
        },
        error:(fail) => {
          console.error('Error retrieving miscellaneas');
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
      if (this.miscellaneaSubscription) {
        this.miscellaneaSubscription.unsubscribe();
      }
      if (this.loggedInSubscription) {
        this.loggedInSubscription.unsubscribe();
      }
    }

    sortMiscellaneasByTitle(): void {
      this.filteredMiscellaneas = this.filteredMiscellaneas.sort((a, b) => a.title.localeCompare(b.title));
      this.sortTitleActive = true;
    }

    // original filter miscellaneas function
    // filterMiscellaneas(): void {
    //   if (this.searchQuery.trim() === '') {
    //     if(this.sortTitleActive) {
    //       this.filteredMiscellaneas = [...this.originalData];
    //       this.sortMiscellaneasByTitle();
    //     }
    //     else {
    //       this.filteredMiscellaneas = [...this.originalData];
    //     }
    //   } else {
    //     if(this.sortTitleActive) {
    //       this.filteredMiscellaneas = this.originalData.filter(miscellanea =>
    //         miscellanea.title.toLowerCase().includes(this.searchQuery.toLowerCase())
    //       );
    //       this.sortMiscellaneasByTitle();
    //     }
    //     else {
    //       this.filteredMiscellaneas = this.originalData.filter(miscellanea =>
    //         miscellanea.title.toLowerCase().includes(this.searchQuery.toLowerCase())
    //       );
    //     }
    //   }
    // }

    filterMiscellaneas(): void {
      this.noMatches = false;
      console.log(this.noMatches);

      if (this.searchQuery.trim() === '') {
        // If the search query is empty, reset to the current filtered data
        this.filteredMiscellaneas = [...this.originalData];
        // Reapply filters if active
        // if (this.filterCopyrightedActive) {
        //   this.filteredStories = this.filteredStories.filter(story => !story.isCopyrighted);
        // }
      } else {
        // Filter based on the current search query
        this.filteredMiscellaneas = this.originalData.filter(miscellanea =>
          miscellanea.title.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
        if (this.filteredMiscellaneas.length === 0) {
          this.noMatches = true;
        }
        // Reapply filters if active
        // if (this.filterCopyrightedActive) {
        //   this.filteredPoems = this.filteredPoems.filter(poem => !poem.isCopyrighted);
        // }
      }
    }

    clearFilters(): void {
      // Reset all filters and restore the original data
      this.filteredMiscellaneas = [...this.originalData];
      this.miscellaneas = [...this.originalData];
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

          // this.searchQuery = '';
        });
      }
    }

    openUserListDialog(miscellanea: any) {
      this.dialogService.openUserListDialog(miscellanea, 'miscellanea');
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
}
