import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Poem } from 'src/app/models/poem';
import { AuthService } from 'src/app/services/auth.service';
import { DialogService } from 'src/app/services/dialog.service';
import { PoemService } from 'src/app/services/poem.service';

@Component({
  selector: 'app-poems',
  templateUrl: './poems.component.html',
  styleUrls: ['./poems.component.css']
})
export class PoemsComponent implements OnInit, OnDestroy {

  // properties initialization
  poems: Poem[] = [];
  originalData: Poem[] = [];
  searchQuery: string = '';
  filteredPoems: Poem[] = [];

  // booleans
  loading: boolean = false;
  sortTitleActive: boolean = false;

  // subscriptions declarations
  private poemSubscription: Subscription | undefined;

  // service injections
  auth = inject(AuthService);
  poemService = inject(PoemService);
  dialogService = inject(DialogService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToSubscriptions();

  }

  ngOnDestroy(): void {
    this.destroySubscriptions();

  }

  subscribeToSubscriptions = () => {
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

  destroySubscriptions = () => {
    if (this.poemSubscription) {
      this.poemSubscription.unsubscribe();
    }
  }

  sortPoemsByTitle(): void {
    this.filteredPoems = this.filteredPoems.sort((a, b) => a.title.localeCompare(b.title));
    this.sortTitleActive = true;
  }

  filterPoems(): void {
    if (this.searchQuery.trim() === '') {
      if(this.sortTitleActive) {
        this.filteredPoems = [...this.originalData];
        this.sortPoemsByTitle();
      }
      else {
        this.filteredPoems = [...this.originalData];
      }
    } else {
      if(this.sortTitleActive) {
        this.filteredPoems = this.originalData.filter(poem =>
          poem.title.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
        this.sortPoemsByTitle();
      }
      else {
        this.filteredPoems = this.originalData.filter(poem =>
          poem.title.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
      }
    }
  }

  clearFilters(): void {
    // Reset all filters and restore the original data
    this.filteredPoems = [...this.originalData];
    this.poems = [...this.originalData];
    this.searchQuery = '';
    this.sortTitleActive = false;
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
}
