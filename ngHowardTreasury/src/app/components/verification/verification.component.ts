import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-verification',
  templateUrl: './verification.component.html',
  styleUrls: ['./verification.component.css']
})
export class VerificationComponent implements OnInit {
  error: boolean = false;
  verifying: boolean = false;
  verificationMessage: string = '';

  constructor(


private route: ActivatedRoute,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    const token = this.route.snapshot.queryParamMap.get('token');

    if (token) {
      this.verifying = true;
      console.log(token);

      this.authService.verifyAccount(token).subscribe({
        next: (response) => {
          this.verifying = false;
          this.error = false;
          this.verificationMessage = 'Your account has been verified successfully! You can now log in.';
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

}
