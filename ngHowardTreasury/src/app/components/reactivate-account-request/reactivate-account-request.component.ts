import { Component, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-reactivate-account-request',
  templateUrl: './reactivate-account-request.component.html',
  styleUrls: ['./reactivate-account-request.component.css']
})
export class ReactivateAccountRequestComponent {

  authService = inject(AuthService);

  // canDeactivate(): Observable<boolean> | boolean {
  //   return this.authService.isAccountVerified();
  // }
}
