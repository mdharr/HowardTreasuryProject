import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, map } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';
import { SnackbarService } from 'src/app/services/snackbar.service';

@Component({
  selector: 'app-reactivate-account-request',
  templateUrl: './reactivate-account-request.component.html',
  styleUrls: ['./reactivate-account-request.component.css']
})
export class ReactivateAccountRequestComponent {

  authService = inject(AuthService);
  snackbarService = inject(SnackbarService);
  router = inject(Router);

  canDeactivate(): Observable<boolean> | boolean {
    // Assuming you have a method in AuthService to check the verification status
    return this.authService.isAccountDeactivated().pipe(
      map(isDeactivated => !isDeactivated)
    );
  }

  // sendVerificationEmail() {
  //   // Logic to send verification email with 6 digit code
  //   // ...
  //   this.authService.sendVerificationEmail().subscribe({
  //     next: () => {
  //       this.openSnackbar('Verification email sent. Please check your email.', 'Dismiss');
  //     },
  //     error: (err) => {
  //       console.error('Failed to send verification email', err);
  //       this.openSnackbar('Failed to send verification email. Please try again later.', 'Dismiss');
  //     }
  //   });
  // }

  // verifyCode(code: string) {
  //   // Logic to verify the 6 digit code
  //   // ...
  //   this.authService.verifyCode(code).subscribe({
  //     next: () => {
  //       this.openSnackbar('Account reactivated successfully!', 'Dismiss');
  //       this.router.navigate(['/']); // Redirect to the home page or dashboard
  //     },
  //     error: (err) => {
  //       console.error('Failed to verify code', err);
  //       this.openSnackbar('Failed to verify code. Please try again.', 'Dismiss');
  //     }
  //   });
  // }

  openSnackbar(message: string, action: string) {
    this.snackbarService.openSnackbar(message, action);
  }
}
