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

  /*

  const profileColorsMap = {
    '0': '#ffb503',  // orange
    '1': '#ffdb01',  // yellow
    '2': '#d6cf05',  // yellow
    '3': '#8bc43d',  // green
    '4': '#00a350',  // green
    '5': '#01a99d',  // blue
    '6': '#02aff0',  // blue
    '7': '#0084ce',  // blue
    '8': '#015fad',  // blue
    '9': '#bcc3c7',  // purple
    'A': '#ff6816',  // orange
    'B': '#ff940e',  // orange
    'C': '#ffb503',  // yellow
    'D': '#ffdb01',  // yellow
    'E': '#d6cf05',  // yellow
    'F': '#8bc43d',  // green
    'G': '#00a350',  // green
    'H': '#01a99d',  // green
    'I': '#02aff0',  // blue
    'J': '#0084ce',  // blue
    'K': '#015fad',  // blue
    'L': '#bcc3c7',  // blue
    'M': '#6c7b87',  // dark purple
    'N': '#273f50',  // purple
    'O': '#1e3894',  // orange
    'P': '#663592',  // orange
    'Q': '#983290',  // yellow
    'R': '#f93174',  // yellow
    'S': '#fb281a',  // green
    'T': '#ff6816',  // green
    'U': '#ff940e',  // blue
    'V': '#ffb503',  // blue
    'W': '#ffdb01',  // blue
    'X': '#d6cf05',  // blue
    'Y': '#8bc43d',  // green
    'Z': '#00a350',  // green
  };


  */
}
