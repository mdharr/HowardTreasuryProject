import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-password-reset',
  templateUrl: './password-reset.component.html',
  styleUrls: ['./password-reset.component.css']
})
export class PasswordResetComponent implements OnInit {
  password: string = '';
  confirmPassword: string = '';
  token: string = '';

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

    this.authService.resetPassword(this.token, this.password).subscribe({
      next: (response) => {
        console.log(response);
        console.log('Password successfully updated!')
      },
      error: (err) => {
        console.error(err);
      }
    });
  }
}
