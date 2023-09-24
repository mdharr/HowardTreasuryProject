import { AfterViewInit, Component, inject, OnDestroy, OnInit, Renderer2 } from '@angular/core';

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
export class NavbarComponent implements OnInit, OnDestroy, AfterViewInit {

  menuState: 'collapsed' | 'expanded' = 'collapsed';
  isMenuOpen: boolean = false;
  searchQuery: string = '';

  loggedInUser: User = new User();

  private loggedInUserSubscription: Subscription | undefined;

  route = inject(ActivatedRoute);
  router = inject(Router);
  authService = inject(AuthService);
  modalService = inject(NgbModal);
  renderer = inject(Renderer2);
  dialogService = inject(DialogService);
  searchService = inject(SearchService);
  searchResultsService = inject(SearchResultsService);

  ngOnInit(): void {
    this.authService.getCurrentLoggedInUser().subscribe((user: User) => {
      this.loggedInUser = user;
      // Do something with the logged-in user object, e.g. update UI
    });

    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (error) => {
        console.log('Error getting loggedInUser');
        console.log(error);
      },
    });

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
  ngOnDestroy(): void {

  }
  ngAfterViewInit(): void {

  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

  // toggleMenu() {
  //   this.menuState = this.menuState === 'collapsed' ? 'expanded' : 'collapsed';
  // }

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

  closeMenu = () => {
    this.menuState = 'collapsed';
  }
}
