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
    private paramsSubscription: Subscription | undefined;
    private authSubscription: Subscription | undefined;

    // service injection
    route = inject(ActivatedRoute);
    router = inject(Router);
    authService = inject(AuthService);
    userListService = inject(UserlistService);

    ngOnInit(): void {

      window.scrollTo(0, 0);

      this.authSubscription = this.authService.getLoggedInUser().subscribe({
        next: (user) => {
          this.loggedInUser = user;
          console.log(this.loggedInUser);
        },
        error: (error) => {
          console.log('Error getting loggedInUser');
          console.log(error);
        },
      });

    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    destroySubscriptions = () => {
      if(this.authSubscription) {
        this.authSubscription.unsubscribe();
        console.log('user-profile comp auth sub destroyed');

      }
    }
}
