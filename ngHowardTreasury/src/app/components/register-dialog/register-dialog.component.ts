import { Component, inject } from '@angular/core';
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
export class RegisterDialogComponent {
  newUser: User = new User();

  auth = inject(AuthService);
  router = inject(Router);
  dialogRef = inject(MatDialogRef<RegisterDialogComponent>);
  snackBar = inject(MatSnackBar);

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
    this.auth.register(newUser).subscribe({
      next: (registeredUser) => {
        this.auth.login(newUser.username, newUser.password).subscribe({
          next: (loggedInUser) => {
            this.dialogRef.close();
            this.router.navigateByUrl('/');
            this.snackBar.open('Success! Welcome ' + this.capitalizeFirstLetter(newUser.username), 'Dismiss', {
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

  dismissDialog() {
    this.dialogRef.close();
  }

  capitalizeFirstLetter(text: string): string {
    return text.charAt(0).toUpperCase() + text.slice(1);
  }
}
