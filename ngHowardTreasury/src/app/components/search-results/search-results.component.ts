import { MatDialog } from '@angular/material/dialog';
import { ImageZoomDirective } from './../../directives/image-zoom.directive';
import { SearchResultsService } from './../../services/search-results.service';
import { Component, inject, Input, OnDestroy, OnInit, AfterViewInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { map, Observable, Subscription } from 'rxjs';
import { JumpToPageDialogComponent } from '../jump-to-page-dialog/jump-to-page-dialog.component';

@Component({
  selector: 'app-search-results',
  templateUrl: './search-results.component.html',
  styleUrls: ['./search-results.component.css'],
})
export class SearchResultsComponent implements OnInit, OnDestroy, AfterViewInit {

  @Input() pageCount: number = 0;
  searchResults: any[] = [];
  searchResultsCount: number = 0;
  currentPage: number = 1;
  pageSize: number = 10;
  pages: number[] = [];
  totalResults: number = 0;
  totalPages: number = 0;
  viewingRangeStart: number = 0;
  viewingRangeEnd: number = 0;
  searchResultsForPage: any[] = [];
  results$: Observable<any[]>;

  // booleans
  isLoaded: boolean = false;
  hasResults: boolean = true;
  imageLoaded = false;

  // subscription declarations
  private searchSubscription: Subscription | undefined;
  private totalResultsSubscription: Subscription | undefined;

  // service injection
  constructor(private dialog: MatDialog, private searchResultsService: SearchResultsService) {
    this.results$ = searchResultsService.searchResults$;
  }

  ngOnInit() {
    window.scrollTo(0, 0);
    this.subscribeToSearchResults();
  }

  ngOnDestroy() {
    this.destroySubscriptions();
  }

  ngAfterViewInit() {

    const options = {
      root: null, // Use the viewport as the root
      rootMargin: '0px',
      threshold: 0.5, // Adjust as needed
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          // Trigger the method to load posts for the current page asynchronously
          this.loadResultsForPage(this.currentPage);
          observer.unobserve(entry.target);
        }
      });
    }, options);

    const paginationElement = document.querySelector('.page-navigation');
    if (paginationElement) {
      observer.observe(paginationElement);
    }
  }

  subscribeToSearchResults = () => {
    this.searchSubscription = this.results$.subscribe((results) => {
      if (results != null) {
        this.searchResults = results;
        this.searchResultsCount = results.length;
      } else {
        this.searchResults = [];
      }
      this.loadResultsForPage(1);
      this.goToPage(1);
      this.isLoaded = true;
    });
  }

  destroySubscriptions = () => {
    if(this.searchSubscription) {
      this.searchSubscription.unsubscribe();
    }
    if (this.totalResultsSubscription) {
      this.totalResultsSubscription.unsubscribe();
    }
  }

  // pagination start
  generatePageArray() {
    const maxVisiblePages = 5; // Maximum number of visible pages in the navigation

    if (this.totalPages <= maxVisiblePages) {
      // If total pages is less than or equal to maxVisiblePages, display all pages
      this.pages = Array.from({ length: this.totalPages }, (_, i) => i + 1);
    } else {
      const firstPage = 1;
      const lastPage = this.totalPages;
      const currentPage = this.currentPage;

      // Add first page
      const pageNumbers: number[] = [firstPage];

      // Add ellipsis if current page is not within the first 3 pages
      if (currentPage > 3) {
        pageNumbers.push(-1);
      }

      // Add visible page numbers
      const startPage = Math.max(2, currentPage - 2);
      const endPage = Math.min(lastPage - 1, currentPage + 2);
      for (let i = startPage; i <= endPage; i++) {
        pageNumbers.push(i);
      }

      // Add ellipsis if current page is not within the last 3 pages
      if (currentPage < lastPage - 2) {
        pageNumbers.push(-1);
      }

      // Add last page
      pageNumbers.push(lastPage);

      this.pages = pageNumbers;
    }
  }

  // Modify the goToPage method
  async goToPage(page: number): Promise<void> {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.generatePageArray();
      await this.loadResultsForPage(page);
      this.scrollToTop();
    }
  }

  loadResultsForPage(page: number): void {
    const startIndex = (page - 1) * this.pageSize;
    let endIndex = startIndex + this.pageSize;

    const totalResults = this.searchResults.length;
    const totalPages = this.getTotalPages();
    const remainingResults = totalResults - startIndex;

    if (remainingResults < this.pageSize) {
      endIndex = startIndex + remainingResults;
    }

    const slicedResults = this.searchResults.slice(startIndex, endIndex);

    this.totalResults = totalResults;
    this.totalPages = totalPages;
    this.generatePageArray();

    this.searchResultsForPage = slicedResults;
    this.searchResultsCount = totalResults

    this.viewingRangeStart = startIndex + 1;
    this.viewingRangeEnd = endIndex;
  }

  goToPreviousPage(): void {
    if (this.currentPage > 1) {
      this.goToPage(this.currentPage - 1);
    }
  }

  goToNextPage(): void {
    if (this.currentPage < this.totalPages) {
      this.goToPage(this.currentPage + 1);
    }
  }

  onJumpToPage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.goToPage(page);
    }
  }

  onJumpToPageDialog() {

    const dialogRef = this.dialog.open(JumpToPageDialogComponent, {
      width: '250px',
      data: { currentPage: this.currentPage, totalPages: this.totalPages } // Pass current page and total pages as data to the dialog
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result && result.page) {
        const page = result.page;
        this.onJumpToPage(page); // Call the onJumpToPage method with the selected page number
        this.scrollToTop();
      }
    });
  }

  getTotalPages(): number {
    return Math.ceil(this.searchResultsCount / this.pageSize);
  }

  // pagination end

  scrollToTop() {
    window.scrollTo(0, 0);
  }

  onImageLoaded(success: boolean) {
    this.imageLoaded = success;
    if (!success) {
      // Handle failed image load - maybe show a placeholder
      console.error('Image failed to load');
    }
  }
}
