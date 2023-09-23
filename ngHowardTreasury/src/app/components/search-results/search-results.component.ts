import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { SearchResultsService } from 'src/app/services/search-results.service';

@Component({
  selector: 'app-search-results',
  templateUrl: './search-results.component.html',
  styleUrls: ['./search-results.component.css']
})
export class SearchResultsComponent implements OnInit {
  searchResults: any[] = [];

  constructor(private searchResultsService: SearchResultsService) {}

  ngOnInit() {
    // Subscribe to the searchResults$ observable to get updated results
    this.searchResultsService.searchResults$.subscribe((results) => {
      this.searchResults = results;
    });
  }

}
