import { trigger, transition, query, style, stagger, animate } from '@angular/animations';
import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { Illustrator } from 'src/app/models/illustrator';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { IllustratorService } from 'src/app/services/illustrator.service';

@Component({
  selector: 'app-illustrators',
  templateUrl: './illustrators.component.html',
  styleUrls: ['./illustrators.component.css'],
  animations: [
    trigger('customEasingAnimation', [
      transition(':enter', [
        query('app-illustrator-card', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(100, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ]
})
export class IllustratorsComponent implements OnInit, OnDestroy {

  // properties
  illustrators: Illustrator[] = [];
  loggedInUser: User = new User();
  showAll: boolean = false;

  // subscriptions
  private authSubscription: Subscription | undefined;
  private illustratorSubscription: Subscription | undefined;

  // service injections
  authService = inject(AuthService);
  illustratorService = inject(IllustratorService);

  ngOnInit() {
    this.subscribeToServices();
    this.triggerCustomEasingAnimation();
  }

  ngOnDestroy() {
    this.destroySubscriptions();
  }

  subscribeToServices = () => {
    this.subscribeToIllustrators();
  }

  destroySubscriptions = () => {
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
    if(this.illustratorSubscription) {
      this.illustratorSubscription.unsubscribe();
    }
  }

  subscribeToAuth = () => {
    this.authSubscription = this.authService.getLoggedInUser().subscribe((user: User) => {
      this.loggedInUser = user;
    });
  }

  subscribeToIllustrators = () => {
    this.illustratorSubscription = this.illustratorService.indexAll().subscribe({
      next: (data) => {
        this.illustrators = data;
        console.log('Illustrators: ', this.illustrators);
      },
      error: (fail) => {
        console.error('Error retrieving illustrators');
        console.error(fail);
      }
    });
  }

  triggerCustomEasingAnimation() {
    // You can use a timeout to trigger the animation after a short delay
    setTimeout(() => {
      this.showAll = true; // Set the showAll to true to trigger the animation
    }, 100);
  }

}
