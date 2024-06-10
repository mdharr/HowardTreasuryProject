import { Component, OnDestroy, OnInit, inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
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

  private passwordResetSub: Subscription | null = null;

  private route = inject(ActivatedRoute);
  private authService = inject(AuthService);

  constructor() {}

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const idString = params.get('token');
      if (idString) {
        this.token = idString;
      }
    });
  }

  onSubmit() {
    if (this.password !== this.confirmPassword) {
      console.error("Passwords do not match");
      return;
    }

    this.passwordResetSub = this.authService.resetPassword(this.token, this.password).subscribe({
      next: (response) => {
        console.log(response);
        console.log('Password successfully updated!')
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

  ngOnDestroy(): void {
    if (this.passwordResetSub) {
      this.passwordResetSub.unsubscribe();
    }
  }
}
