import { AddToUserListDialogComponent } from './../components/add-to-user-list-dialog/add-to-user-list-dialog.component';
import { inject, Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { LoginDialogComponent } from '../components/login-dialog/login-dialog.component';
import { RegisterDialogComponent } from '../components/register-dialog/register-dialog.component';

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

  openUserListDialog(item: any) {
    this.dialog.open(AddToUserListDialogComponent, {
      width: '400px',
      data: { item: item } // Pass the 'item' data here
    });
  }
}
