import { Component, HostListener, inject, OnDestroy, OnInit, ViewChild, Renderer2 } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { AnimatedCardComponent } from '../animated-card/animated-card.component';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy {

  objectPosition: string = '-470px center';

  // booleans
  isLoaded = false;

  authService = inject(AuthService);
  renderer = inject(Renderer2);

  ngOnInit() {
    window.scrollTo(0, 0);
    this.updateObjectPosition();
    setTimeout(() => {
      this.isLoaded = true;
    }, 250);
  }

  ngOnDestroy() {

  }

  updateObjectPosition() {
    if (window.innerWidth < 1028) {
      this.objectPosition = '-388px center'; // Update to the desired value
    } else {
      this.objectPosition = '-470px center'; // Update to the desired value
    }
  }

  @HostListener('window:resize', ['$event'])
  onResize(event: Event): void {
    this.updateObjectPosition();
  }



}
