import { SnackbarService } from './../../services/snackbar.service';
import { UserService } from './../../services/user.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { Component, inject, ChangeDetectorRef } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-login-dialog',
  templateUrl: './login-dialog.component.html',
  styleUrls: ['./login-dialog.component.css']
})
export class LoginDialogComponent {
  loginUser: User = new User();

  loginForm = new FormGroup({
    username: new FormControl('', [Validators.required]),
    password: new FormControl('', [Validators.required])
  });

  dialogRef = inject(MatDialogRef<LoginDialogComponent>);
  auth = inject(AuthService);
  userService = inject(UserService);
  userListService = inject(UserlistService);
  cdr = inject(ChangeDetectorRef);
  snackbarService = inject(SnackbarService);

  login(loginUser: User) {
    // this.auth.login(this.loginUser.username, this.loginUser.password).subscribe({
    //   next: (loggedInUser) => {
    //     console.log("Login success");
    //     this.loginUser = loggedInUser;
    //     this.userListService.loadUserLists();
    //     this.dialogRef.close();
    //     this.openSnackbar('Login Success!', 'Dismiss');
    //     // Notify the UserService about the successful login
    //     this.userService.updateUser(loggedInUser);
    //   },
    //   error: (fail) => {
    //     console.error('Login fail');
    //     console.error(fail);
    //     this.openSnackbar('Login Failed.', 'Dismiss');
    //   }
    // });
    if (this.loginForm.valid) {
      const formValues = this.loginForm.value;
      const username = formValues.username!;
      const password = formValues.password!;

      this.auth.login(username, password).subscribe({
        next: (loggedInUser) => {
          console.log("Login success");
          this.loginUser = loggedInUser;
          this.userListService.loadUserLists();
          this.dialogRef.close();
          this.openSnackbar('Welcome back ' + this.loginUser.username + '!', 'Dismiss');
          // Notify the UserService about the successful login
          this.userService.updateUser(loggedInUser);
        },
        error: (fail) => {
          console.error('Login fail');
          console.error(fail);
          this.openSnackbar('The username or password you entered is incorrect.', 'Dismiss');
        }
      });
    }
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
