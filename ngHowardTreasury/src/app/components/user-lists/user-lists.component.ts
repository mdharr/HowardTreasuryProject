import { UserlistService } from './../../services/userlist.service';
import { Component, OnInit, OnDestroy, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { User } from 'src/app/models/user';
import { UserList } from 'src/app/models/user-list';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-user-lists',
  templateUrl: './user-lists.component.html',
  styleUrls: ['./user-lists.component.css']
})
export class UserListsComponent implements OnInit, OnDestroy {

  // property initialization
  loggedInUser: User = new User();
  userLists: UserList[] = [];

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
      console.log('user-lists comp auth sub destroyed');
    }
  }

  removeSelectedStories = (userList: UserList) => {

  }

  removeSelectedPoems = (userList: UserList) => {

  }

  removeSelectedMiscellaneas = (userList: UserList) => {

  }

}
