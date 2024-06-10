import { ChangeDetectorRef, Component, OnDestroy, inject } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-password-reset-request',
  templateUrl: './password-reset-request.component.html',
  styleUrls: ['./password-reset-request.component.css']
})
export class PasswordResetRequestComponent implements OnDestroy {
  email: string = '';
  error: boolean = false;
  sending: boolean = false;
  statusMessage: string = '';
  countdown: number = 5;
  countdownStarted: boolean = false;

  private countdownSubscription: Subscription | null = null;
  private passwordResetSub: Subscription | null = null;

  private authService = inject(AuthService);
  private cdr = inject(ChangeDetectorRef);
  private router = inject(Router);

  constructor() {}

  onSubmit(e: Event) {
    e.preventDefault();

    this.sending = true;
    this.cdr.detectChanges();

    this.passwordResetSub = this.authService.requestPasswordReset(this.email).subscribe({
      next: (response) => {
        console.log(response);
        this.statusMessage = 'Email sent. Please check your inbox.';
        this.cdr.detectChanges();
        this.sending = false;
        this.error = false;
        this.cdr.detectChanges();
        this.startCountdown();
      },
      error: (err) => {
        console.error(err);
        this.statusMessage = 'There was an error sending the email. Please try again or contact support.';
        this.cdr.detectChanges();
        this.sending = false;
        this.error = true;
      }
    })
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
  }
}
