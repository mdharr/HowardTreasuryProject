import { SearchResultsService } from './../../services/search-results.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-search-results',
  templateUrl: './search-results.component.html',
  styleUrls: ['./search-results.component.css']
})
export class SearchResultsComponent implements OnInit, OnDestroy {
  searchResults: any[] = [];
  searchResultsCount: number = 0;

  // booleans
  isLoaded: boolean = false;
  hasResults: boolean = true;

  // subscription declarations
  private searchSubscription: Subscription | undefined;

  // inject services
  searchResultsService = inject(SearchResultsService);

  ngOnInit() {
    this.subscribeToSearchResults();
  }

  ngOnDestroy() {
    this.destroySubscriptions();
  }

  subscribeToSearchResults = () => {
    // Subscribe to the searchResults$ observable to get updated results
    this.searchSubscription = this.searchResultsService.searchResults$.subscribe((results) => {
      if(results != null) {
        this.searchResults = results;
        this.searchResultsCount = 0;
        for(let i = 0; i < results.length; i++) {
          this.searchResultsCount++;
        }
      }
      else {
        this.hasResults = false;
      }
      setTimeout(() => {
        this.isLoaded = true;
      }, 250);
    });
  }

  destroySubscriptions = () => {
    if(this.searchSubscription) {
      this.searchSubscription.unsubscribe();
    }
  }

}
