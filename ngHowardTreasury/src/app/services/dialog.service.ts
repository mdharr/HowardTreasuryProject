import { CreateUserListDialogComponent } from './../components/create-user-list-dialog/create-user-list-dialog.component';
import { AddToUserListDialogComponent } from './../components/add-to-user-list-dialog/add-to-user-list-dialog.component';
import { inject, Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { LoginDialogComponent } from '../components/login-dialog/login-dialog.component';
import { RegisterDialogComponent } from '../components/register-dialog/register-dialog.component';
import { UserList } from '../models/user-list';

@Injectable({
  providedIn: 'root'
})
export class DialogService {

  dialog = inject(MatDialog);

  openLoginDialog() {
    this.dialog.open(LoginDialogComponent, {
      width: '400px', // Set the desired width
    });
  }

  openRegisterDialog() {
    this.dialog.open(RegisterDialogComponent, {
      width: '400px', // Set the desired width
    });
  }

  openUserListDialog(object: any, objectType: string) {
    this.dialog.open(AddToUserListDialogComponent, {
      width: '400px',
      data: { object: object, objectType: objectType } // Pass the object as data to the dialog component
    });
  }

  openCreateUserListDialog(userList: UserList) {
    this.dialog.open(CreateUserListDialogComponent,{
      width: '400px',
      data: { userList: UserList }
    });
  }
}
