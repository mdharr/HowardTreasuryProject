import { Component, inject } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Illustrator } from 'src/app/models/illustrator';
import { StoryImage } from 'src/app/models/story-image';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { IllustratorService } from 'src/app/services/illustrator.service';

@Component({
  selector: 'app-illustrator-details',
  templateUrl: './illustrator-details.component.html',
  styleUrls: ['./illustrator-details.component.css']
})
export class IllustratorDetailsComponent {
  // properties
  illustrator: Illustrator = new Illustrator();
  storyImages: StoryImage[] = [];
  loggedInUser: User = new User();
  illustratorId: number = 0;

  // subscriptions
  private authSubscription: Subscription | undefined;
  private illustratorSubscription: Subscription | undefined;
  private paramsSubscription: Subscription | undefined;

  // service injections
  authService = inject(AuthService);
  illustratorService = inject(IllustratorService);
  activatedRoute = inject(ActivatedRoute);

  ngOnInit() {
    this.subscribeToServices();
  }

  ngOnDestroy() {
    this.destroySubscriptions();
  }

  subscribeToServices = () => {
    this.getRouteParams();
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
    if(this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
  }

  getRouteParams = () => {
    this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
      let idString = params.get('illustratorId');
      if(idString) {
        this.illustratorId = +idString;
      }
    });
  }

  subscribeToAuth = () => {
    this.authSubscription = this.authService.getLoggedInUser().subscribe((user: User) => {
      this.loggedInUser = user;
    });
  }

  subscribeToIllustrators = () => {
    this.illustratorSubscription = this.illustratorService.find(this.illustratorId).subscribe({
      next: (data) => {
        this.illustrator = data;
        this.storyImages = data.storyImages;
      },
      error: (fail) => {
        console.error('Error retrieving illustrators');
        console.error(fail);
      }
    });
  }
}
