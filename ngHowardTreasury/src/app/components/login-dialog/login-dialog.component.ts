import { SnackbarService } from './../../services/snackbar.service';
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
  userListService = inject(UserlistService);
  cdr = inject(ChangeDetectorRef);
  snackbarService = inject(SnackbarService);

  login(loginUser: User) {
    this.auth.login(this.loginUser.username, this.loginUser.password).subscribe({
      next: (loggedInUser) => {
        console.log("Login success");
        this.loginUser = loggedInUser;
        this.userListService.loadUserLists();
        this.dialogRef.close();
        this.openSnackbar('Login Success!', 'Dismiss');
        // Notify the UserService about the successful login
        this.userService.updateUser(loggedInUser);
      },
      error: (fail) => {
        console.error('Login fail');
        console.error(fail);
        this.openSnackbar('Login Failed.', 'Dismiss');
      }
    });
  }

  dismissDialog() {
    this.dialogRef.close();
  }

  refreshPage() {
    window.location.reload();
  }

  openSnackbar(message: string, action: string) {
    this.snackbarService.openSnackbar(message, action);
  }
}
