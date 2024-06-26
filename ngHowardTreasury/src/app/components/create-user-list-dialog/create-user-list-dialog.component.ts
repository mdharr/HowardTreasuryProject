import { Component, inject, Inject, OnDestroy, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { User } from 'src/app/models/user';
import { UserList } from 'src/app/models/user-list';
import { AuthService } from 'src/app/services/auth.service';
import { UserlistService } from 'src/app/services/userlist.service';

@Component({
  selector: 'app-create-user-list-dialog',
  templateUrl: './create-user-list-dialog.component.html',
  styleUrls: ['./create-user-list-dialog.component.css']
})
export class CreateUserListDialogComponent implements OnInit, OnDestroy {
    // property initialization
  loggedInUser: User = new User();
  newUserListName: string = '';

  private authSubscription: Subscription | undefined;
  private userListSubscription: Subscription | undefined;

  constructor(
    private dialogRef: MatDialogRef<CreateUserListDialogComponent>,
    @Inject(MAT_DIALOG_DATA) private data: any,
    private authService: AuthService,
    private userListService: UserlistService
  ) {}

  ngOnInit(): void {
    this.subscribeToAuth();
  }

  subscribeToAuth = () => {
    this.authSubscription = this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (error) => {
        console.error('Error getting loggedInUser');
        console.error(error);
      },
    });
  }

  ngOnDestroy(): void {
    if (this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
    if (this.userListSubscription) {
      this.userListSubscription.unsubscribe();
    }
  }

  createUserList() {
    // Create a new UserList object with the name
    const userList: UserList = {
      name: this.newUserListName,
      id: 0,
      user: this.loggedInUser,
      stories: [],
      poems: [],
      miscellaneas: [],
      selected: false,
    };

    if (this.newUserListName.toLowerCase() === "favorites") {
      this.dialogRef.close();
      return;
    }

    this.userListSubscription = this.userListService.createUserList(userList).subscribe({
      next: (data) => {
        this.dialogRef.close();
      },
      error: (fail) => {
        console.error('Error creating user list:', fail);
      }
    });
  }

  closeDialog() {
    this.dialogRef.close();
  }
}
