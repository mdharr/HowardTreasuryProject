import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
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

    // service injection
    route = inject(ActivatedRoute);
    router = inject(Router);
    authService = inject(AuthService);
    userListService = inject(UserlistService);

    ngOnInit(): void {
      window.scrollTo(0, 0);
      this.subscribeToLoggedInObservable();
    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    destroySubscriptions = () => {
      if(this.loggedInSubscription) {
        this.loggedInSubscription.unsubscribe();
      }
    }

    subscribeToLoggedInObservable() {
      this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
        this.loggedInUser = user;
      });
    }
}
