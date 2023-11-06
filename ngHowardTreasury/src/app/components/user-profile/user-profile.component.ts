import { DialogService } from 'src/app/services/dialog.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription, tap } from 'rxjs';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserlistService } from 'src/app/services/userlist.service';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit, OnDestroy {

    // property initialization
    loggedInUser: User = new User();

    // booleans
    isLoggedIn: boolean = false;

    // subscriptions
    private loggedInSubscription: Subscription | undefined;
    private loggedInUserSubscription: Subscription | undefined;

    // service injection
    authService = inject(AuthService);
    dialogService = inject(DialogService);

    ngOnInit(): void {
      window.scrollTo(0, 0);
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

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    destroySubscriptions = () => {
      if(this.loggedInSubscription) {
        this.loggedInSubscription.unsubscribe();
      }
      if(this.loggedInUserSubscription) {
        this.loggedInUserSubscription.unsubscribe();
      }
    }

    subscribeToLoggedInObservable() {
      this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
        this.loggedInUser = user;
        console.log('Logged in user:', this.loggedInUser);

      });
    }

    openUpdateUserDialog(user: User) {
      this.dialogService.openUserUpdateDialog(user);
    }
}
