import { Component, OnInit, ChangeDetectorRef, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-verification',
  templateUrl: './verification.component.html',
  styleUrls: ['./verification.component.css']
})
export class VerificationComponent implements OnInit, OnDestroy {
  error: boolean = false;
  verifying: boolean = false;
  verificationMessage: string = '';
  countdown: number = 5;

  private countdownSubscription: Subscription | null = null;

  constructor(
    private route: ActivatedRoute,
    private authService: AuthService,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    const token = this.route.snapshot.queryParamMap.get('token');

    if (token) {
      this.verifying = true;

      this.authService.verifyAccount(token).subscribe({
        next: (response) => {
          this.verifying = false;
          this.error = false;
          this.verificationMessage = 'Your account has been verified successfully! You can now log in.';
          this.startCountdown();
        },
        error: (err) => {
          this.verifying = false;
          this.error = true;
          // Log the entire error object to see the detailed error response from the server
          console.error(err);
          this.verificationMessage = 'There was an error with your email verification. Please try again or contact support.';
        }
      });
    } else {
      this.error = true;
      this.verifying = false;
      this.verificationMessage = 'No verification token found. Please ensure you have used the correct verification link.';
    }
  }

  startCountdown() {
    this.countdown = 5;
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
    if (this.countdownSubscription) {
      this.countdownSubscription.unsubscribe();
    }
  }
}
