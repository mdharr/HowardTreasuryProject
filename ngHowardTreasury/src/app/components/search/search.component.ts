import { Component, inject } from '@angular/core';
import { SearchService } from 'src/app/services/search.service';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent {

  query: string = '';
  searchResults: any[] = [];
  loading: boolean = false;
  error: string | null = null;

  searchService = inject(SearchService);

  search() {
    this.loading = true;
    this.error = null;

    this.searchService.search(this.query)
      .subscribe(
        (results: any[]) => {
          this.searchResults = results;
          this.loading = false;
        },
        (error) => {
          this.error = 'An error occurred while searching.';
          this.loading = false;
        }
      );
  }

}
