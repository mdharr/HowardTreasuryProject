import { SearchResultsService } from './../../services/search-results.service';
import { Component, inject, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-search-results',
  templateUrl: './search-results.component.html',
  styleUrls: ['./search-results.component.css']
})
export class SearchResultsComponent implements OnInit {
  searchResults: any[] = [];
  searchResultsCount: number = 0;

  // booleans
  isLoaded = false;

  // inject services
  searchResultsService = inject(SearchResultsService);

  ngOnInit() {
    // Subscribe to the searchResults$ observable to get updated results
    this.searchResultsService.searchResults$.subscribe((results) => {
      this.searchResults = results;
      this.searchResultsCount = 0;
      for(let i = 0; i < results.length; i++) {
        this.searchResultsCount++;
      }
      setTimeout(() => {
        this.isLoaded = true;
      }, 250);
    });

  }

}
