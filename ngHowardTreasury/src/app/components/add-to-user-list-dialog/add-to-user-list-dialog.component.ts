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
    selectedUserLists: UserList[] = []; // Array to store selected user lists
    isAnyUserListSelectedFlag: boolean = false;
    selectedItem: any;


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
    dialogRef = inject(MatDialogRef<AddToUserListDialogComponent>)

    ngOnInit(): void {
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

    closeDialog() {
      this.dialogRef.close();
    }

}
