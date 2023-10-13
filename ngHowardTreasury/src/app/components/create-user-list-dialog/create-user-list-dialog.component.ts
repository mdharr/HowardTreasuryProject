import { Component, inject, Inject } from '@angular/core';
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
export class CreateUserListDialogComponent {
    // property initialization
  loggedInUser: User = new User();
  newUserListName: string = '';

  private authSubscription: Subscription | undefined;

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

    this.userListService.createUserList(userList).subscribe({
      next: (data) => {
        console.log('User list created:', data);
        this.dialogRef.close(); // Close the dialog
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
