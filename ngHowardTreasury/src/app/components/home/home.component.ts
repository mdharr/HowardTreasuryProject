import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy {

  authService = inject(AuthService);

  ngOnInit() {
    this.tempTestDeleteMeLater(); // DELETE LATER
  }

  ngOnDestroy() {

  }

  tempTestDeleteMeLater() {
    this.authService.login('admin','wombat1').subscribe({
      next: (data) => {
        console.log('Logged in:');
        console.log(data);
      },
      error: (fail) => {
        console.error('Error authenticating:');
        console.error(fail);

      }
    });
  }
}
