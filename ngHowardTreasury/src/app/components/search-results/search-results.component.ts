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
  searchResultsCount: number = 0;

  constructor(private searchResultsService: SearchResultsService) {}

  ngOnInit() {
    // Subscribe to the searchResults$ observable to get updated results
    this.searchResultsService.searchResults$.subscribe((results) => {
      this.searchResults = results;
      for(let i = 0; i < results.length; i++) {
        this.searchResultsCount++;
      }
    });
  }

}
