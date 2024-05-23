import { DialogService } from 'src/app/services/dialog.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription, tap } from 'rxjs';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit, OnDestroy {

    // property initialization
    loggedInUser: User = new User();
    loggedInUserImageUrl: string = '';

    // booleans
    isLoggedIn: boolean = false;
    isLoaded: boolean = false;

    // subscriptions
    private loggedInSubscription: Subscription | undefined;
    private loggedInUserSubscription: Subscription | undefined;

    // service injection
    authService = inject(AuthService);
    userService = inject(UserService);
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
          console.error('Error getting loggedInUser Profile Component');
          console.error(error);
        },
      });

      this.userService.userUpdated$.subscribe(user => {
        this.loggedInUser = user;
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
      });
    }

    openUpdateUserDialog(user: User) {
      this.dialogService.openUserUpdateDialog(user);
    }

    setImageUrl(event: Event) {
      const imageElement = event.target as HTMLImageElement;
      if (imageElement) {
        this.loggedInUserImageUrl = imageElement.src;
        this.isLoaded = true;
      }
    }

}
