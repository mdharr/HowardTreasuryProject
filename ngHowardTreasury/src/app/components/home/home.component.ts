import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy {

  // booleans
  isLoaded = false;

  authService = inject(AuthService);

  ngOnInit() {
    window.scrollTo(0, 0);
    setTimeout(() => {
      this.isLoaded = true;
    }, 250);
  }

  ngOnDestroy() {

  }

}
