import { ChangeDetectorRef, Component, OnDestroy, OnInit, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
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

  private passwordResetSub: Subscription | null = null;

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
      console.error("Passwords do not match");
      this.statusMessage = 'Passwords do not match.';
      setTimeout(() => {
        this.processing = false;
      }, 2000);
      return;
    }

    this.processing = true;

    this.passwordResetSub = this.authService.resetPassword(this.token, this.password).subscribe({
      next: (response) => {
        this.statusMessage = 'Password successfully updated!';
        this.cdr.detectChanges();
        this.processing = false;
        this.error = false;
        this.cdr.detectChanges();
        this.startCountdown();
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
  }

}
