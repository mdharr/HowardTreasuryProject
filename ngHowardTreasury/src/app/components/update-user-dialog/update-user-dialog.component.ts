import { UserService } from './../../services/user.service';
import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { Subscription, tap } from 'rxjs';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { RegisterDialogComponent } from '../register-dialog/register-dialog.component';
import { SnackbarService } from 'src/app/services/snackbar.service';

@Component({
  selector: 'app-update-user-dialog',
  templateUrl: './update-user-dialog.component.html',
  styleUrls: ['./update-user-dialog.component.css']
})
export class UpdateUserDialogComponent implements OnInit, OnDestroy {
  tempUser: User = new User();
  loggedInUser: User = new User();
  profileDescriptionError: boolean = false;

  // subscription declarations
  private authSubscription: Subscription | undefined;
  private loggedInUserSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;

  auth = inject(AuthService);
  router = inject(Router);
  dialogRef = inject(MatDialogRef<RegisterDialogComponent>);
  snackBar = inject(MatSnackBar);
  userService = inject(UserService);
  snackbarService = inject(SnackbarService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToLoggedInObservable();
    this.loggedInUserSubscription = this.auth.getLoggedInUser().pipe(
      tap(user => {
        this.loggedInUser = user;
        this.tempUser = { ...this.loggedInUser };
      })
    ).subscribe({
      error: (error) => {
        console.error('Error getting loggedInUser Profile Component');
        console.error(error);
      },
    });
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.auth.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
      this.tempUser = { ...this.loggedInUser };
    });
  }

  dismissDialog() {
    this.dialogRef.close();
  }

  capitalizeFirstLetter(text: string): string {
    return text.charAt(0).toUpperCase() + text.slice(1);
  }

  ngOnDestroy = () => {
    this.destroySubscriptions();
  }

  update() {
    // Validate profileDescription length
    if (this.tempUser.profileDescription.length > 300) {
      this.profileDescriptionError = true;
      this.openSnackbar('Profile Description must be no more than 300 characters.', 'Dismiss');
      return;
    }

    // Clear the error if validation passes
    this.profileDescriptionError = false;

    this.authSubscription = this.auth.updateUser(this.tempUser).subscribe({
      next: (data) => {
        this.dialogRef.close();
        this.openSnackbar('Update successful', 'Dismiss');
        this.userService.updateUser(this.tempUser);
      },
      error: (err) => {
        console.error(err);
        this.openSnackbar('Update unsuccessful', 'Dismiss');
      }
    });
  }

  destroySubscriptions = () => {
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
    if(this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
    if(this.loggedInUserSubscription) {
      this.loggedInUserSubscription.unsubscribe();
    }
  }

  openSnackbar(message: string, action: string) {
    this.snackbarService.openSnackbar(message, action);
  }
}
