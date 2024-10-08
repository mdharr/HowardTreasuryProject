import { Component, HostListener, inject, OnDestroy, OnInit, ViewChild, Renderer2, ViewChildren, QueryList } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { AnimatedCardComponent } from '../animated-card/animated-card.component';
import { User } from 'src/app/models/user';
import { Subscription } from 'rxjs';
import { DialogService } from 'src/app/services/dialog.service';

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

  private loggedInSubscription: Subscription | undefined;

  authService = inject(AuthService);
  renderer = inject(Renderer2);
  dialogService = inject(DialogService);

  ngOnInit() {
    window.scrollTo(0, 0);
    this.updateObjectPosition();
    setTimeout(() => {
      this.isLoaded = true;
    }, 250);
  }

  ngOnDestroy() {
    if (this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
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
    let totalImages = 0;
    let loadedImages = 0;

    this.animatedCards.forEach((card) => {
      totalImages += 2;

      card.imagesLoaded.subscribe(() => {
        loadedImages++;

        if (loadedImages === totalImages) {
          this.isLoaded = true;
        }
      });
    });
  }

  openLoginDialog() {
    this.dialogService.openLoginDialog();
  }

  openRegisterDialog() {
    this.dialogService.openRegisterDialog();
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

}
