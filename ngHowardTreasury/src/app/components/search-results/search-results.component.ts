import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-search-results',
  templateUrl: './search-results.component.html',
  styleUrls: ['./search-results.component.css']
})
export class SearchResultsComponent implements OnInit {
  searchResults: any[] = [];

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    // Retrieve route parameter 'results'
    const resultsRouteParam = this.route.snapshot.paramMap.get('results');

    if (resultsRouteParam) {
      this.searchResults = JSON.parse(resultsRouteParam);
      console.log('Search results:', this.searchResults);
    } else {
      console.log('No search results found.');
    }
  }

}
