import { Component, inject } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { RegisterDialogComponent } from '../register-dialog/register-dialog.component';

@Component({
  selector: 'app-update-user-dialog',
  templateUrl: './update-user-dialog.component.html',
  styleUrls: ['./update-user-dialog.component.css']
})
export class UpdateUserDialogComponent {
  newUser: User = new User();

  // subscription declarations
  private authSubscription: Subscription | undefined;

  auth = inject(AuthService);
  router = inject(Router);
  dialogRef = inject(MatDialogRef<RegisterDialogComponent>);
  snackBar = inject(MatSnackBar);
  userListService = inject(UserlistService);

  register(newUser: User): void {
    console.log('Registering user:');
    console.log(newUser);
    if (newUser.password !== newUser.confirmPassword) {
      // Password and confirmPassword do not match
      console.log("Passwords do not match");
      this.snackBar.open('Passwords do not match', 'Dismiss', {
        duration: 4000,
        panelClass: ['mat-toolbar', 'mat-primary'],
        verticalPosition: 'bottom'
      });
      return;
    }
    this.subscribeToAuth();
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

  subscribeToAuth = () => {
    this.authSubscription = this.auth.register(this.newUser).subscribe({
      next: (registeredUser) => {
        this.auth.login(this.newUser.username, this.newUser.password).subscribe({
          next: (loggedInUser) => {
            this.userListService.loadUserLists();
            this.dialogRef.close();
            this.router.navigateByUrl('/');
            this.snackBar.open('Success! Welcome ' + this.capitalizeFirstLetter(this.newUser.username), 'Dismiss', {
              duration: 4000,
              panelClass: ['mat-toolbar', 'mat-primary'],
              verticalPosition: 'bottom'
            });
          },
          error: (problem) => {
            console.error('RegisterComponent.register(): Error logging in user:');
            console.error(problem);
            this.snackBar.open('Signup unsuccessful', 'Dismiss', {
              duration: 4000,
              panelClass: ['mat-toolbar', 'mat-primary'],
              verticalPosition: 'bottom'
            });
          }
        });
      },
      error: (fail) => {
        console.error('RegisterComponent.register(): Error registering account');
        console.error(fail);
      }
    });
  }

  destroySubscriptions = () => {
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
  }
}
