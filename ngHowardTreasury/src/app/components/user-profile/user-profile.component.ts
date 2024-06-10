import { DialogService } from 'src/app/services/dialog.service';
import { ChangeDetectorRef, Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription, tap } from 'rxjs';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit, OnDestroy {

    // property initialization
    loggedInUser: User = new User();
    loggedInUserImageUrl: string = '';
    firstLetter: string = '';
    userProfileColor: string = '';
    profileColorsObject: { [key: string]: string } = {
      '0': '#ffb503',
      '1': '#ffdb01',
      '2': '#d6cf05',
      '3': '#8bc43d',
      '4': '#00a350',
      '5': '#01a99d',
      '6': '#02aff0',
      '7': '#0084ce',
      '8': '#015fad',
      '9': '#bcc3c7',
      'A': '#ff6816',
      'B': '#ff940e',
      'C': '#ffb503',
      'D': '#ffdb01',
      'E': '#d6cf05',
      'F': '#8bc43d',
      'G': '#00a350',
      'H': '#01a99d',
      'I': '#02aff0',
      'J': '#0084ce',
      'K': '#015fad',
      'L': '#bcc3c7',
      'M': '#6c7b87',
      'N': '#273f50',
      'O': '#1e3894',
      'P': '#663592',
      'Q': '#983290',
      'R': '#f93174',
      'S': '#fb281a',
      'T': '#ff6816',
      'U': '#ff940e',
      'V': '#ffb503',
      'W': '#ffdb01',
      'X': '#d6cf05',
      'Y': '#8bc43d',
      'Z': '#00a350',
    };

    profileColorsMap = new Map<string, string>();

    // booleans
    isLoggedIn: boolean = false;
    isLoaded: boolean = false;

    // subscriptions
    private loggedInSubscription: Subscription | undefined;
    private loggedInUserSubscription: Subscription | undefined;

    // service injection
    authService = inject(AuthService);
    userService = inject(UserService);
    dialogService = inject(DialogService);
    cdr = inject(ChangeDetectorRef);

    ngOnInit(): void {
      window.scrollTo(0, 0);

      this.profileColorsMap = new Map(Object.entries(this.profileColorsObject));

      this.subscribeToLoggedInObservable();
      this.loggedInUserSubscription = this.authService.getLoggedInUser().pipe(
        tap(user => {
          this.loggedInUser = user;
          this.firstLetter = this.loggedInUser.username.charAt(0);
          this.userProfileColor = this.getColorForChar(this.loggedInUser.username.charAt(0));
        })
      ).subscribe({
        error: (error) => {
          console.error('Error getting loggedInUser Profile Component');
          console.error(error);
        },
      });

      // this.userService.userUpdated$.subscribe(user => {
      //   this.loggedInUser = user;
      // });
      this.userService.userUpdated$.subscribe(user => {
        this.loggedInUser = user;
        this.refreshImageUrl(this.loggedInUser.imageUrl);
        this.cdr.detectChanges(); // Trigger change detection
      });
    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    destroySubscriptions = () => {
      if(this.loggedInSubscription) {
        this.loggedInSubscription.unsubscribe();
      }
      if(this.loggedInUserSubscription) {
        this.loggedInUserSubscription.unsubscribe();
      }
    }

    subscribeToLoggedInObservable() {
      this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
        this.loggedInUser = user;
      });
    }

    openUpdateUserDialog(user: User) {
      this.dialogService.openUserUpdateDialog(user);
    }

    setImageUrl(event: Event) {
      const imageElement = event.target as HTMLImageElement;
      if (imageElement) {
        this.loggedInUserImageUrl = imageElement.src;
        this.isLoaded = true;
      }
    }

    refreshImageUrl(imageUrl: string) {
      if (imageUrl && imageUrl !== '') {
        this.loggedInUserImageUrl = imageUrl;
        this.isLoaded = true;
      } else {
        this.loggedInUserImageUrl = '';
        this.isLoaded = false;
      }
      this.cdr.detectChanges(); // Trigger change detection
    }

    getColorForChar(char: string): string {
      return this.profileColorsMap.get(char.toUpperCase()) ?? '#ffffff';
    }

}
