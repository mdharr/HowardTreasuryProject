import { UserService } from './../../services/user.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { Component, inject, ChangeDetectorRef } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { CustomSnackbarComponent } from '../custom-snackbar/custom-snackbar.component';

@Component({
  selector: 'app-login-dialog',
  templateUrl: './login-dialog.component.html',
  styleUrls: ['./login-dialog.component.css']
})
export class LoginDialogComponent {
  loginUser: User = new User();

  dialogRef = inject(MatDialogRef<LoginDialogComponent>);
  auth = inject(AuthService);
  userService = inject(UserService);
  snackBar = inject(MatSnackBar);
  userListService = inject(UserlistService);
  cdr = inject(ChangeDetectorRef);
  snackbarRef = inject(MatDialogRef<CustomSnackbarComponent>);

  login(loginUser: User) {
    this.auth.login(this.loginUser.username, this.loginUser.password).subscribe({
      next: (loggedInUser) => {
        console.log("Login success");
        this.loginUser = loggedInUser;
        this.userListService.loadUserLists();
        this.dialogRef.close();
        // Open the snackbar with an action handler
        this.snackBar.openFromComponent(CustomSnackbarComponent, {
          data: { message: 'Login Success!', action: 'Dismiss' },
          duration: 4000
        }).onAction().subscribe(() => {
          this.dismissSnackbar();
        });
        // Notify the UserService about the successful login
        this.userService.updateUser(loggedInUser);
      },
      error: (fail) => {
        console.error('Login fail');
        console.error(fail);
        this.snackBar.open('Incorrect username or password', 'Dismiss', {
          duration: 4000,
          panelClass: ['mat-toolbar', 'mat-warn'],
          verticalPosition: 'bottom'
        });
      }
    });
  }

  dismissDialog() {
    this.dialogRef.close();
  }

  refreshPage() {
    window.location.reload();
  }

  showCustomSnackbar(message: string, action?: string, actionHandler?: Function) {
    const snackBarRef = this.snackBar.openFromComponent(CustomSnackbarComponent, {
      data: { message, action, actionHandler },
      duration: 4000
    });

    if (action && actionHandler) {
      snackBarRef.onAction().subscribe(() => actionHandler());
    }
  }

  // Define an action handler
  dismissSnackbar() {
    // Perform additional actions here if necessary
  }
}
