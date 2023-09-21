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
          overflow: 'hidden',
          opacity: '0',
        })
      ),
      state(
        'expanded',
        style({
          height: '*',
          overflow: 'visible',
          opacity: '1',
        })
      ),
      transition('collapsed <=> expanded', [animate('300ms cubic-bezier(0.68, -0.55, 0.27, 1.55)')]),
    ]),
    trigger('menuIcon', [
      state('menu', style({ transform: 'rotate(0deg)' })),
      state('close', style({ transform: 'rotate(45deg)' })),
      transition('menu <=> close', animate('200ms ease-in-out')),
    ]),
  ],
})
export class NavbarComponent implements OnInit, OnDestroy, AfterViewInit {

  menuState: 'collapsed' | 'expanded' = 'collapsed';
  isMenuOpen: boolean = false;

  loggedInUser: User = new User();

  private loggedInUserSubscription: Subscription | undefined;

  route = inject(ActivatedRoute);
  router = inject(Router);
  authService = inject(AuthService);
  modalService = inject(NgbModal);
  renderer = inject(Renderer2);
  dialogService = inject(DialogService);

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
}
