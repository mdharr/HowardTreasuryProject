import { UserlistService } from 'src/app/services/userlist.service';
import { Component, inject, ChangeDetectorRef } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login-dialog',
  templateUrl: './login-dialog.component.html',
  styleUrls: ['./login-dialog.component.css']
})
export class LoginDialogComponent {
  loginUser: User = new User();

  dialogRef = inject(MatDialogRef<LoginDialogComponent>);
  auth = inject(AuthService);
  snackBar = inject(MatSnackBar);
  userListService = inject(UserlistService);
  cdr = inject(ChangeDetectorRef);

  login(loginUser: User) {
    this.auth.login(this.loginUser.username, this.loginUser.password).subscribe({
      next: (loggedInUser) => {
        console.log("Login success");
        this.loginUser = loggedInUser;
        this.userListService.loadUserLists();
        this.dialogRef.close();
        this.snackBar.open('Login Success!', 'Dismiss', {
          duration: 4000,
          panelClass: ['mat-toolbar', 'mat-primary'],
          verticalPosition: 'bottom'
        });
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
}
