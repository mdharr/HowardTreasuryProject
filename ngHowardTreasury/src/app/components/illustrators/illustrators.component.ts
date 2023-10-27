import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { Illustrator } from 'src/app/models/illustrator';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { IllustratorService } from 'src/app/services/illustrator.service';

@Component({
  selector: 'app-illustrators',
  templateUrl: './illustrators.component.html',
  styleUrls: ['./illustrators.component.css']
})
export class IllustratorsComponent implements OnInit, OnDestroy {

  // properties
  illustrators: Illustrator[] = [];
  loggedInUser: User = new User();

  // subscriptions
  private authSubscription: Subscription | undefined;
  private illustratorSubscription: Subscription | undefined;

  // service injections
  authService = inject(AuthService);
  illustratorService = inject(IllustratorService);

  ngOnInit() {
    this.subscribeToServices();
  }

  ngOnDestroy() {
    this.destroySubscriptions();
  }

  subscribeToServices = () => {
    this.subscribeToAuth();
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

}
