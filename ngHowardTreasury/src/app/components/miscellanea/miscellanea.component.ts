import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Miscellanea } from 'src/app/models/miscellanea';
import { AuthService } from 'src/app/services/auth.service';
import { DialogService } from 'src/app/services/dialog.service';
import { MiscellaneaService } from 'src/app/services/miscellanea.service';

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

    // booleans
    loading: boolean = false;
    sortTitleActive: boolean = false;

    // subscriptions declarations
    private miscellaneaSubscription: Subscription | undefined;

    // service injections
    auth = inject(AuthService);
    miscellaneaService = inject(MiscellaneaService);
    dialogService = inject(DialogService);

    ngOnInit(): void {
      window.scrollTo(0, 0);
      this.subscribeToSubscriptions();
    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    subscribeToSubscriptions = () => {
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

    destroySubscriptions = () => {
      if (this.miscellaneaSubscription) {
        this.miscellaneaSubscription.unsubscribe();
      }
    }

    sortMiscellaneasByTitle(): void {
      this.filteredMiscellaneas = this.filteredMiscellaneas.sort((a, b) => a.title.localeCompare(b.title));
      this.sortTitleActive = true;
    }

    filterMiscellaneas(): void {
      if (this.searchQuery.trim() === '') {
        if(this.sortTitleActive) {
          this.filteredMiscellaneas = [...this.originalData];
          this.sortMiscellaneasByTitle();
        }
        else {
          this.filteredMiscellaneas = [...this.originalData];
        }
      } else {
        if(this.sortTitleActive) {
          this.filteredMiscellaneas = this.originalData.filter(miscellanea =>
            miscellanea.title.toLowerCase().includes(this.searchQuery.toLowerCase())
          );
          this.sortMiscellaneasByTitle();
        }
        else {
          this.filteredMiscellaneas = this.originalData.filter(miscellanea =>
            miscellanea.title.toLowerCase().includes(this.searchQuery.toLowerCase())
          );
        }
      }
    }

    clearFilters(): void {
      // Reset all filters and restore the original data
      this.filteredMiscellaneas = [...this.originalData];
      this.miscellaneas = [...this.originalData];
      this.searchQuery = '';
      this.sortTitleActive = false;
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
