import { SnackbarService } from './../../services/snackbar.service';
import { UserlistService } from 'src/app/services/userlist.service';
import { Component, inject } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent {
  userId: number = 0; // Retrieve userId from AuthService

  auth = inject(AuthService);
  router = inject(Router);
  snackBar = inject(MatSnackBar);
  userListService = inject(UserlistService);
  snackbarService = inject(SnackbarService);

  logout() {
    console.log("Logging out");
    this.userListService.clearUserLists();
    this.auth.logout();
    this.router.navigateByUrl('home');
    this.openSnackbar('Logged Out', 'Dismiss');
  }

  openSnackbar(message: string, action: string) {
    this.snackbarService.openSnackbar(message, action);
  }
}
