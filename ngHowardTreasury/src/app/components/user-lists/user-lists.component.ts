import { UserlistService } from './../../services/userlist.service';
import { Component, OnInit, OnDestroy, inject, QueryList, ViewChildren, AfterViewInit } from '@angular/core';
import { MatExpansionPanel } from '@angular/material/expansion';
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
export class UserListsComponent implements OnInit, OnDestroy, AfterViewInit {

  // property initialization
  loggedInUser: User = new User();
  userLists: UserList[] = [];
  newUserList: UserList = new UserList();
  userLists$: Observable<UserList[]> | undefined;
  isLoading: boolean = true;

  // booleans
  isLoggedIn: boolean = false;

  // subscriptions
  private authSubscription: Subscription | undefined;
  private removeItemsSubscription: Subscription | undefined;
  private createListSubscription: Subscription | undefined;
  private userListsSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;

  // service injection
  route = inject(ActivatedRoute);
  router = inject(Router);
  authService = inject(AuthService);
  userListService = inject(UserlistService);
  dialogService = inject(DialogService);

  @ViewChildren('expansionPanel') expansionPanels!: QueryList<MatExpansionPanel>;

  ngOnInit(): void {
    this.subscribeToLoggedInObservable();
    this.userListService.loadUserLists();
    this.userLists$ = this.userListService.userLists$;
    setTimeout(() => {
      this.isLoading = false;
    }, 50);
  }

  ngOnDestroy(): void {
    this.destroySubscriptions();
  }

  ngAfterViewInit() {
    this.expansionPanels.forEach(panel => panel.expanded = false);
  }

  destroySubscriptions = () => {
    if(this.removeItemsSubscription) {
      this.removeItemsSubscription.unsubscribe();
    }
    if(this.createListSubscription) {
      this.createListSubscription.unsubscribe();
    }
    if (this.userListsSubscription) {
      this.userListsSubscription.unsubscribe();
    }
    if (this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
      this.userLists = user.userLists;
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
      },
      error: error => {
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

      },
      error: (fail) => {
        console.error(fail);
        console.error('Error deleting user list ' + fail);
      }
    });
  }

}
