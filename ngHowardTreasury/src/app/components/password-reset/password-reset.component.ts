import { ChangeDetectorRef, Component, OnDestroy, OnInit, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription, of, switchMap } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-password-reset',
  templateUrl: './password-reset.component.html',
  styleUrls: ['./password-reset.component.css']
})
export class PasswordResetComponent implements OnInit, OnDestroy {
  password: string = '';
  confirmPassword: string = '';
  token: string = '';
  statusMessage: string = '';
  error: boolean = false;
  processing: boolean = false;
  countdown: number = 5;
  countdownStarted: boolean = false;
  passwordPattern: RegExp = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-\=\[\]{};':"\\|,.<>\/?]).{8,}$/;

  private passwordResetSub: Subscription | null = null;
  private passwordCheckSub: Subscription | null = null;

  private route = inject(ActivatedRoute);
  private authService = inject(AuthService);
  private cdr = inject(ChangeDetectorRef);
  private router = inject(Router);

  constructor() {}

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const idString = params.get('token');
      if (idString) {
        this.token = idString;
      }
    });
  }

  onSubmit(e: Event) {
    e.preventDefault();

    if (this.password !== this.confirmPassword) {
      this.statusMessage = 'Passwords do not match. Please try again.';
      this.error = true;
      setTimeout(() => {
        this.error = false;
      }, 2000);
      return;
    }

    if (!this.validatePassword(this.password)) {
      this.statusMessage = 'Passwords must be a minimum of 8 characters and contain at least one uppercase letter, one number, and one special character.';
      this.error = true;
      setTimeout(() => {
        this.error = false;
      }, 2000);
      return;
    }

    this.processing = true;

    this.passwordCheckSub = this.authService.checkPassword(this.token, this.password).pipe(
      switchMap((passwordsMatch) => {
        if (passwordsMatch) {
          this.statusMessage = 'New password cannot be the same as the old password.';
          this.error = true;
          setTimeout(() => {
            this.error = false;
          }, 2000);
          this.processing = false;
          return of(null); // Return an observable that emits null to stop the chain
        } else {
          return this.authService.resetPassword(this.token, this.password); // Continue with password reset
        }
      })
    ).subscribe({
      next: (response) => {
        if (response !== null) {
          this.statusMessage = 'Password successfully updated!';
          this.cdr.detectChanges();
          this.processing = false;
          this.error = false;
          this.cdr.detectChanges();
          this.startCountdown();
        }
      },
      error: (err) => {
        console.error(err);
        this.statusMessage = 'There was an error resetting the password. Please try again or contact support.';
        this.cdr.detectChanges();
        this.processing = false;
        this.error = true;
      }
    });
  }

  startCountdown() {
    this.countdownStarted = true;
    this.countdown = 5;
    this.cdr.detectChanges();
    const intervalId = setInterval(() => {
      this.countdown -= 1;
      this.cdr.detectChanges(); // Trigger change detection manually

      if (this.countdown < 0) {
        clearInterval(intervalId);
        this.router.navigateByUrl('/');
      }
    }, 1000);
  }

  ngOnDestroy(): void {
    if (this.passwordResetSub) {
      this.passwordResetSub.unsubscribe();
    }
    if (this.passwordCheckSub) {
      this.passwordCheckSub.unsubscribe();
    }
  }

  validatePassword(password: string): boolean {
    return this.passwordPattern.test(password);
  }

}
