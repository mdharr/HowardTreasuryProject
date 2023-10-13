import { Component, inject, Inject, OnInit, OnDestroy } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { User } from 'src/app/models/user';
import { UserList } from 'src/app/models/user-list';
import { AuthService } from 'src/app/services/auth.service';
import { UserlistService } from 'src/app/services/userlist.service';

@Component({
  selector: 'app-add-to-user-list-dialog',
  templateUrl: './add-to-user-list-dialog.component.html',
  styleUrls: ['./add-to-user-list-dialog.component.css']
})
export class AddToUserListDialogComponent implements OnInit, OnDestroy {

    // property initialization
    loggedInUser: User = new User();
    userLists: UserList[] = [];
    newUserListName: string = '';
    userList: UserList = new UserList();
    selectedUserLists: UserList[] = [];
    isAnyUserListSelectedFlag: boolean = false;
    selectedItem: any;
    objectType: any;


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

    constructor(
      private dialogRef: MatDialogRef<AddToUserListDialogComponent>,
      @Inject(MAT_DIALOG_DATA) private data: any
    ) { }

    ngOnInit(): void {

      this.selectedItem = this.data.object;
      this.objectType = this.data.objectType;

      this.authSubscription = this.authService.getLoggedInUser().subscribe({
        next: (user) => {
          this.loggedInUser = user;

        },
        error: (error) => {
          console.log('Error getting loggedInUser');
          console.log(error);
        },
      });
    }

    ngOnDestroy(): void {
      if (this.authSubscription) {
        this.authSubscription.unsubscribe();
      }
    }

    userListContainsObject(userList: UserList, object: any, objectType: string): boolean {
      if (objectType === 'story') {
        return userList.stories.some(story => story.id === object.id);
      } else if (objectType === 'poem') {
        return userList.poems.some(poem => poem.id === object.id);
      } else if (objectType === 'miscellanea') {
        return userList.miscellaneas.some(misc => misc.id === object.id);
      } else {
        return false; // Handle unknown object types or return an appropriate default value
      }
    }


    addToSelectedUserLists() {
      const selectedUserListIds = this.loggedInUser.userLists
      .filter(userList => userList.selected)
      .map(userList => userList.id);

      if (selectedUserListIds.length > 0) {
        this.userListService
          .addObjectToUserLists(this.selectedItem.id, this.objectType, selectedUserListIds)
          .subscribe(updatedUserLists => {
            // Handle the response, e.g., close the dialog
            this.closeDialog();
          });
      }
    }

    closeDialog() {
      this.dialogRef.close();
    }

}
