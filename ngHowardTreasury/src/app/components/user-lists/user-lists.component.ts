import { UserlistService } from './../../services/userlist.service';
import { Component, OnInit, OnDestroy, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable, Subscription } from 'rxjs';
import { User } from 'src/app/models/user';
import { UserList } from 'src/app/models/user-list';
import { AuthService } from 'src/app/services/auth.service';
import { DialogService } from 'src/app/services/dialog.service';

@Component({
  selector: 'app-user-lists',
  templateUrl: './user-lists.component.html',
  styleUrls: ['./user-lists.component.css']
})
export class UserListsComponent implements OnInit, OnDestroy {

  // property initialization
  loggedInUser: User = new User();
  userLists: UserList[] = [];
  newUserList: UserList = new UserList();
  userLists$: Observable<UserList[]> | undefined;

  // booleans
  isLoggedIn: boolean = false;

  // subscriptions
  private authSubscription: Subscription | undefined;

  // service injection
  route = inject(ActivatedRoute);
  router = inject(Router);
  authService = inject(AuthService);
  userListService = inject(UserlistService);
  dialogService = inject(DialogService);

  ngOnInit(): void {
    this.userLists$ = this.userListService.userLists$;

    this.subscribeToAuth();
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

  subscribeToAuth = () => {
    this.authSubscription = this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        this.userLists = user.userLists;
        console.log(this.loggedInUser);
      },
      error: (error) => {
        console.log('Error getting loggedInUser');
        console.log(error);
      },
    });
  }

  removeSelectedItems(userList: UserList) {
    const selectedStories = userList.stories.filter(story => story.selected);
    const selectedPoems = userList.poems.filter(poem => poem.selected);
    const selectedMiscellaneas = userList.miscellaneas.filter(miscellanea => miscellanea.selected);

    const itemsToRemove = {
      story: selectedStories.map(story => story.id),
      poem: selectedPoems.map(poem => poem.id),
      miscellanea: selectedMiscellaneas.map(miscellanea => miscellanea.id)
    };

    // Call the service method to remove selected items
    this.userListService.removeItemsFromUserList(userList.id, itemsToRemove).subscribe({
      next: updatedUserList => {
        // Update the user list in the component with the received data
        userList.stories = updatedUserList.stories;
        userList.poems = updatedUserList.poems;
        userList.miscellaneas = updatedUserList.miscellaneas;

        // Optionally, you can perform additional UI updates or actions here
      },
      error: error => {
        // Handle any errors that occurred during the request (if needed).
        console.error('Error removing items from user list:', error);
      }
    });
  }

  openCreateUserListDialog(newUserList: UserList) {
    this.dialogService.openCreateUserListDialog(newUserList);
  }

}
