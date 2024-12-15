import { UserService } from './../../services/user.service';
import { AfterViewInit, Component, ElementRef, HostListener, inject, OnDestroy, OnInit, Renderer2, ViewChild } from '@angular/core';

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
import { KeywordsTrie } from 'src/app/utils/trie/keywords-trie';
import { KEYWORDS } from 'src/app/utils/trie/keywords.data';

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
          opacity: '0',
        })
      ),
      state(
        'expanded',
        style({
          height: '*',
          opacity: '1',
        })
      ),
      transition('collapsed <=> expanded', [animate('300ms cubic-bezier(0.68, -0.55, 0.27, 1.55)')]),
    ]),
  ],
})
export class NavbarComponent implements OnInit, OnDestroy {

  @ViewChild('searchInput') searchInput!: ElementRef;
  @ViewChild('ghostInput') ghostInput!: ElementRef;
  @ViewChild('dropdownSearchInput') dropdownSearchInput!: ElementRef;
  @ViewChild('dropdownGhostInput') dropdownGhostInput!: ElementRef;

  searchQuery: string = '';
  keywordsTrie: KeywordsTrie;

  menuState: 'collapsed' | 'expanded' = 'collapsed';
  isMenuOpen: boolean = false;

  loggedInUser: User = new User();

  private loggedInUserSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;
  private userUpdateSubscription: Subscription | undefined;

  route = inject(ActivatedRoute);
  router = inject(Router);
  authService = inject(AuthService);
  modalService = inject(NgbModal);
  renderer = inject(Renderer2);
  dialogService = inject(DialogService);
  userService = inject(UserService);
  searchService = inject(SearchService);
  searchResultsService = inject(SearchResultsService);

  constructor() {
    this.keywordsTrie = new KeywordsTrie();
    // Initialize trie with titles
    KEYWORDS.forEach(title => this.keywordsTrie.insert(title));
  }

  ngOnInit(): void {
    if (this.loggedIn()) {
      this.subscribeToLoggedInObservable();

      // this.loggedInUserSubscription = this.authService.getLoggedInUser().pipe(
      //   tap(user => {
      //     this.loggedInUser = user;
      //     console.log('NavbarComponent ngOnInit loggedInUser:', this.loggedInUser);
      //   })
      // ).subscribe({
      //   error: (error) => {
      //     console.log('Error getting loggedInUser Profile Component');
      //     console.log(error);
      //   },
      // });
    }

    // Subscribe to userUpdated$ from the UserService to update the user in the NavbarComponent
    this.userUpdateSubscription = this.userService.userUpdated$.subscribe(user => {
      this.loggedInUser = user;
    });

  }

  ngOnDestroy(): void {
    if(this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
    if(this.loggedInUserSubscription) {
      this.loggedInUserSubscription.unsubscribe();
    }
    if(this.userUpdateSubscription) {
      this.userUpdateSubscription.unsubscribe();
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
        // Update the search results in the shared service
        this.searchResultsService.updateSearchResults(results);
        this.router.navigate(['/search-results']);

        this.searchQuery = '';
        this.ghostInput.nativeElement.value = '';
      });
      this.toggleMenu();
    }
  }

  performSearchNoMenu() {
    if (this.searchQuery) {
      this.searchService.search(this.searchQuery).subscribe((results) => {
        this.searchResultsService.updateSearchResults(results);
        this.router.navigate(['/search-results']);

        this.searchQuery = '';
        this.ghostInput.nativeElement.value = '';
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

  onSearchInput(event: Event, isDropdown: boolean = false) {
    const userInput = (event.target as HTMLInputElement).value;
    const suggestion = this.keywordsTrie.findMatch(userInput);

    const ghostInput = isDropdown ? this.dropdownGhostInput : this.ghostInput;

    if (suggestion && userInput) {
      // Get the matching part that should use user's capitalization
      const matchingPart = userInput;
      // Get the suggested part that comes after the user's input
      const suggestedPart = suggestion.slice(userInput.length);
      // Combine them, keeping the user's capitalization for the matching part
      ghostInput.nativeElement.value = matchingPart + suggestedPart;
    } else {
      ghostInput.nativeElement.value = '';
    }
  }

  onKeyDown(event: KeyboardEvent, isDropdown: boolean = false) {
    if (event.key === 'Tab') {
      event.preventDefault();

      const ghostInput = isDropdown ? this.dropdownGhostInput : this.ghostInput;

      if (ghostInput.nativeElement.value) {
        this.searchQuery = ghostInput.nativeElement.value;
        ghostInput.nativeElement.value = '';
      }
    }
  }
}
