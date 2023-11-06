import { UserService } from './../../services/user.service';
import { AfterViewInit, Component, HostListener, inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';

import {
  trigger,
  state,
  style,
  animate,
  transition,
} from '@angular/animations';
import { DialogService } from 'src/app/services/dialog.service';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { Subscription, tap } from 'rxjs';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { SearchService } from 'src/app/services/search.service';
import { SearchResultsService } from 'src/app/services/search-results.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css'],
  animations: [
    trigger('expandMenu', [
      state(
        'collapsed',
        style({
          height: '0',
          // overflow: 'hidden',
          opacity: '0',
        })
      ),
      state(
        'expanded',
        style({
          height: '*',
          // overflow: 'visible',
          opacity: '1',
        })
      ),
      transition('collapsed <=> expanded', [animate('300ms cubic-bezier(0.68, -0.55, 0.27, 1.55)')]),
    ]),
  ],
})
export class NavbarComponent implements OnInit, OnDestroy {

  menuState: 'collapsed' | 'expanded' = 'collapsed';
  isMenuOpen: boolean = false;
  searchQuery: string = '';

  loggedInUser: User = new User();

  private loggedInUserSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;

  route = inject(ActivatedRoute);
  router = inject(Router);
  authService = inject(AuthService);
  modalService = inject(NgbModal);
  renderer = inject(Renderer2);
  dialogService = inject(DialogService);
  userService = inject(UserService);
  searchService = inject(SearchService);
  searchResultsService = inject(SearchResultsService);

  ngOnInit(): void {
    if (this.loggedIn()) {
      this.subscribeToLoggedInObservable();

      this.loggedInUserSubscription = this.authService.getLoggedInUser().pipe(
        tap(user => {
          this.loggedInUser = user;
        })
      ).subscribe({
        error: (error) => {
          console.log('Error getting loggedInUser Profile Component');
          console.log(error);
        },
      });
    }

    // Subscribe to userUpdated$ from the UserService to update the user in the NavbarComponent
    this.userService.userUpdated$.subscribe(user => {
      this.loggedInUser = user;
    });
  }

  ngOnDestroy(): void {
    if(this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
    });
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

  toggleMenu() {
    this.menuState = this.menuState === 'collapsed' ? 'expanded' : 'collapsed';
    this.isMenuOpen = !this.isMenuOpen;
  }

  openLoginDialog() {
    this.dialogService.openLoginDialog();
  }

  openSignupDialog() {
    this.dialogService.openRegisterDialog();
  }

  performSearch() {
    if (this.searchQuery) {
      this.searchService.search(this.searchQuery).subscribe((results) => {
        console.log('Search results from service:', results);
        // Update the search results in the shared service
        this.searchResultsService.updateSearchResults(results);
        this.router.navigate(['/search-results']);

        this.searchQuery = '';
      });
      this.toggleMenu();
    }
  }

  performSearchNoMenu() {
    if (this.searchQuery) {
      this.searchService.search(this.searchQuery).subscribe((results) => {
        console.log('Search results from service:', results);
        // Update the search results in the shared service
        this.searchResultsService.updateSearchResults(results);
        this.router.navigate(['/search-results']);

        this.searchQuery = '';
      });
    }
  }

  closeMenu = () => {
    this.menuState = 'collapsed';
    this.isMenuOpen = false;
  }

  @HostListener('window:resize', ['$event'])
  onResize(event: any): void {
  // Check the screen width and close the menu if it's greater than 1087px
  if (window.innerWidth > 1087) {
    this.closeMenu();
  }
}

}
