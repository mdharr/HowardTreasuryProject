import { SnackbarService } from './../../services/snackbar.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { Subscription } from 'rxjs';
import { Component, inject, OnDestroy } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-register-dialog',
  templateUrl: './register-dialog.component.html',
  styleUrls: ['./register-dialog.component.css']
})
export class RegisterDialogComponent implements OnDestroy {
  newUser: User = new User();
  isProcessing:boolean = false;

  // subscription declarations
  private authSubscription: Subscription | undefined;

  auth = inject(AuthService);
  router = inject(Router);
  dialogRef = inject(MatDialogRef<RegisterDialogComponent>);
  snackBar = inject(MatSnackBar);
  userListService = inject(UserlistService);
  snackbarService = inject(SnackbarService);

  register(newUser: User): void {
    console.log('Registering user:');
    console.log(newUser);
    if (newUser.password !== newUser.confirmPassword) {
      // Password and confirmPassword do not match
      console.log("Passwords do not match");
      this.openSnackbar('Passwords do not match', 'Dismiss');
      return;
    }
    this.isProcessing = true;
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
        this.isProcessing = false;
        this.dialogRef.close(); // Close the registration dialog
        this.openSnackbar('Registration successful! Please check your email to verify your account', 'Dismiss');
      },
      error: (fail) => {
        // Handle registration error
        console.error('RegisterComponent.register(): Error registering account');
        console.error(fail);
        this.isProcessing = false;
        this.dialogRef.close();
        this.openSnackbar('Registration unsuccessful', 'Dismiss');
      }
    });
  }

  destroySubscriptions = () => {
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
  }

  openSnackbar(message: string, action: string) {
    this.snackbarService.openSnackbar(message, action);
  }
}
