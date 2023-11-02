import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { SearchService } from 'src/app/services/search.service';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit, OnDestroy {

  // property initialization
  query: string = '';
  searchResults: any[] = [];
  loading: boolean = false;
  error: string | null = null;

  // subscription declarations
  private searchSubscription: Subscription | undefined;

  // service injection
  searchService = inject(SearchService);

  ngOnInit = () => {
    this.search();
  }

  ngOnDestroy = () => {
    this.destroySubscriptions();
  }

  // refined search function
  search = () => {
    this.loading = true;
    this.error = null;

    this.searchSubscription = this.searchService.search(this.query).subscribe({
      next: (results: any[]) => {
        this.searchResults = results;
        this.loading = false;
      },
      error: (fail) => {
        this.error = 'An error occurred while searching.';
        this.loading = false;
      }
    });
  }

  destroySubscriptions = () => {
    if(this.searchSubscription) {
      this.searchSubscription.unsubscribe();
    }
  }

}
