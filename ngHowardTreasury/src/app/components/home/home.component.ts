import { Component, HostListener, inject, OnDestroy, OnInit, ViewChild, Renderer2, ViewChildren, QueryList } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { AnimatedCardComponent } from '../animated-card/animated-card.component';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, OnDestroy {
  @ViewChildren(AnimatedCardComponent) animatedCards!: QueryList<AnimatedCardComponent>;

  objectPosition: string = '-420px center';

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
    if (window.innerWidth < 442) {
      this.objectPosition = '-265px center';
    }
    else if (window.innerWidth < 1028) {
      this.objectPosition = '-388px center';
    }
    else {
      this.objectPosition = '-420px center';
    }
  }

  @HostListener('window:resize', ['$event'])
  onResize(event: Event): void {
    this.updateObjectPosition();
  }

  ngAfterViewInit(): void {
    this.checkImagesLoaded();
  }

  checkImagesLoaded() {
    // Initialize total and loaded counts
    let totalImages = 0;
    let loadedImages = 0;

    // Iterate through each AnimatedCardComponent
    this.animatedCards.forEach((card) => {
      // Update the totalImages count
      totalImages += 2; // You have 3 images in each card

      // Listen for the imagesLoaded event in each AnimatedCardComponent
      card.imagesLoaded.subscribe(() => {
        // Increment the loadedImages count
        loadedImages++;

        // Check if all images are loaded
        if (loadedImages === totalImages) {
          this.isLoaded = true;
        }
      });
    });
  }


}
