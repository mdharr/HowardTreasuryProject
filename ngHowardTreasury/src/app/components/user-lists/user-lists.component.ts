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
  private removeItemsSubscription: Subscription | undefined;
  private createListSubscription: Subscription | undefined;
  private userListsSubscription: Subscription | undefined;

  // service injection
  route = inject(ActivatedRoute);
  router = inject(Router);
  authService = inject(AuthService);
  userListService = inject(UserlistService);
  dialogService = inject(DialogService);

  ngOnInit(): void {

    this.refreshUserLists();
    this.subscribeToAuth();
  }

  ngOnDestroy(): void {
    this.destroySubscriptions();
  }

  destroySubscriptions = () => {
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();

    }
    if(this.removeItemsSubscription) {
      this.removeItemsSubscription.unsubscribe();

    }
    if(this.createListSubscription) {
      this.createListSubscription.unsubscribe();

    }
    if (this.userListsSubscription) {
      this.userListsSubscription.unsubscribe();
    }
  }

  subscribeToAuth = () => {
    this.authSubscription = this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        this.userLists = user.userLists;

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
    this.removeItemsSubscription = this.userListService.removeItemsFromUserList(userList.id, itemsToRemove).subscribe({
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

  deleteUserList = (userList: UserList):void => {
    this.createListSubscription = this.userListService.deleteUserList(userList.id).subscribe({
      next: (success) => {
        console.log('User list successfully deleted');

      },
      error: (fail) => {
        console.error(fail);
        console.error('Error deleting user list ' + fail);
      }
    });
  }

  refreshUserLists() {

    if (this.userListsSubscription) {
      this.userListsSubscription.unsubscribe();
    }

    this.userLists$ = this.userListService.userLists$;

    this.userListsSubscription = this.userLists$.subscribe({
      next: (userLists) => {
        // Log the userLists data
        console.log('Received user lists:', userLists);
        // Handle the updated user lists
        this.userLists = userLists;
      },
      error: (error) => {
        console.error('Error fetching user lists:', error);
      }
    });

  }

}
