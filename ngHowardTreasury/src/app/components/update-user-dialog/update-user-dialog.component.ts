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

@Component({
  selector: 'app-update-user-dialog',
  templateUrl: './update-user-dialog.component.html',
  styleUrls: ['./update-user-dialog.component.css']
})
export class UpdateUserDialogComponent implements OnInit, OnDestroy {
  newUser: User = new User();
  loggedInUser: User = new User();

  // subscription declarations
  private authSubscription: Subscription | undefined;
  private loggedInUserSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;

  auth = inject(AuthService);
  router = inject(Router);
  dialogRef = inject(MatDialogRef<RegisterDialogComponent>);
  snackBar = inject(MatSnackBar);
  userService = inject(UserService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToLoggedInObservable();
    this.loggedInUserSubscription = this.auth.getLoggedInUser().pipe(
      tap(user => {
        this.loggedInUser = user;
      })
    ).subscribe({
      error: (error) => {
        console.log('Error getting loggedInUser Profile Component');
        console.log(error);
      },
    });
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.auth.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
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
    this.authSubscription = this.auth.updateUser(this.loggedInUser).subscribe({
      next: (data) => {
        this.dialogRef.close();
        this.snackBar.open('Update successful', 'Dismiss', {
          duration: 4000,
          panelClass: ['mat-toolbar', 'mat-primary'],
          verticalPosition: 'bottom'
        });
        this.userService.updateUser(this.loggedInUser);
      },
      error: (err) => {
        console.error(err);
        this.snackBar.open('Update unsuccessful', 'Dismiss', {
          duration: 4000,
          panelClass: ['mat-toolbar', 'mat-primary'],
          verticalPosition: 'bottom'
        });
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
}
