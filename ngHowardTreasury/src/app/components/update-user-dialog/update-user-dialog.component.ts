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

  dismissDialog() {
    this.dialogRef.close();
  }

  capitalizeFirstLetter(text: string): string {
    return text.charAt(0).toUpperCase() + text.slice(1);
  }

  ngOnDestroy = () => {
    this.destroySubscriptions();
  }

  update(user: User) {
    this.authSubscription = this.auth.updateUser(user).subscribe({
      next: (data) => {
        this.dialogRef.close();
        this.snackBar.open('Update successful', 'Dismiss', {
          duration: 4000,
          panelClass: ['mat-toolbar', 'mat-primary'],
          verticalPosition: 'bottom'
        });
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
  }
}
