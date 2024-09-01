import { SnackbarService } from './../../services/snackbar.service';
import { UserService } from './../../services/user.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { Component, inject, ChangeDetectorRef } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login-dialog',
  templateUrl: './login-dialog.component.html',
  styleUrls: ['./login-dialog.component.css']
})
export class LoginDialogComponent {

  private snackbarRef: any;

  private countdownTimer: any;
  private waitTime: number = 0;

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
  router = inject(Router);

  login(loginUser: User) {
    if (this.loginForm.valid) {
      const formValues = this.loginForm.value;
      const username = formValues.username!;
      const password = formValues.password!;

      this.auth.login(username, password).subscribe({
        next: (loggedInUser) => {
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

  newLogin(loginUser: User) {

    if (this.loginForm.valid) {
      const formValues = this.loginForm.value;
      const username = formValues.username!;
      const password = formValues.password!;

      this.auth.login(username, password).subscribe({
        next: (loggedInUser) => {
          this.loginUser = loggedInUser;
          this.userListService.loadUserLists();
          this.dialogRef.close();
          this.openSnackbar('Welcome back ' + this.loginUser.username + '!', 'Dismiss');
          // Notify the UserService about the successful login
          this.userService.updateUser(loggedInUser);
        },
        error: (fail) => {

          if (fail.status === 404 && fail.error === 'User not found') {
            this.openSnackbar('User not found.', 'Dismiss');
          } else if (fail.status === 403 && fail.error === 'User account is deactivated') {
            this.openSnackbar('User deactivated account.', 'Dismiss');
            this.dialogRef.close();
            this.router.navigate(['/enable-account-request']);
          } else if (fail.status === 429) {
              // Parse the error response
              const errorBody = fail.error;
              console.log(errorBody);
              // Check if the error body has a 'message' property and it contains 'Rate limit exceeded'
              if (errorBody && errorBody.includes('Rate limit exceeded')) {
                this.waitTime = parseInt(errorBody.replace(/[^0-9]/g, ''), 10);
                this.showRateLimitMessage();
              } else {
                this.openSnackbar('Too many requests. Please try again later.', 'Dismiss');
              }
            } else {
            console.error('Login fail');
            console.error(fail);
            this.openSnackbar('The username or password you entered is incorrect.', 'Dismiss');
          }

        }
      });
    }
  }

  private showRateLimitMessage() {
    // Clear any existing interval
    if (this.countdownTimer) {
      clearInterval(this.countdownTimer);
    }

    const updateMessage = () => {
      const message = `Too many login attempts. Please try again in ${this.waitTime} seconds.`;
      if (this.waitTime > 0) {
        this.snackbarService.updateSnackbarMessage(message);
      } else {
        this.snackbarService.dismiss();
        clearInterval(this.countdownTimer);
      }
    };

    // Open the initial snackbar
    this.snackbarService.openSnackbar(`Too many login attempts. Please try again in ${this.waitTime} seconds.`, 'Dismiss');

    // Start the countdown
    this.countdownTimer = setInterval(() => {
      this.waitTime--;
      updateMessage();
    }, 1000);
  }

  ngOnDestroy() {
    if (this.countdownTimer) {
      clearInterval(this.countdownTimer);
    }
    this.snackbarService.dismiss();
  }

  // newLogin(loginUser: User) {
  //   if (this.loginForm.valid) {
  //     const formValues = this.loginForm.value;
  //     const username = formValues.username!;
  //     const password = formValues.password!;

  //     this.auth.newLogin(username, password).subscribe({
  //       next: (response) => {
  //         const { user, deactivated } = response;
  //         this.loginUser = user;
  //         this.userListService.loadUserLists();
  //         if (deactivated) {
  //           this.dialogRef.close();
  //           this.openSnackbar('Account is deactivated. Redirecting to reactivation page.', 'Dismiss');
  //         } else {
  //           this.dialogRef.close();
  //           this.openSnackbar('Welcome back ' + this.loginUser.username + '!', 'Dismiss');
  //           this.userService.updateUser(user);
  //         }
  //       },
  //       error: (fail) => {
  //         console.error('Login fail');
  //         console.error(fail);

  //         if (fail.status === 404 && fail.error === 'User not found') {
  //           this.openSnackbar('User not found.', 'Dismiss');
  //         } else if (fail.status === 403 && fail.error === 'User account is not enabled') {
  //           this.openSnackbar('User account is not enabled.', 'Dismiss');
  //           this.dialogRef.close();
  //         } else {
  //           this.openSnackbar('The username or password you entered is incorrect.', 'Dismiss');
  //         }
  //       }
  //     });
  //   }
  // }

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
