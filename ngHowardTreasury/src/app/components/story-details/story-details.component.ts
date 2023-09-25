import { Component, inject, OnDestroy, OnInit, Renderer2, AfterViewInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { Story } from 'src/app/models/story';
import { AuthService } from 'src/app/services/auth.service';
import { StoryService } from 'src/app/services/story.service';

@Component({
  selector: 'app-story-details',
  templateUrl: './story-details.component.html',
  styleUrls: ['./story-details.component.css']
})
export class StoryDetailsComponent implements OnInit, OnDestroy, AfterViewInit {

    // property initialization
    storyId: number = 0;
    story: Story = new Story();
    storyExcerpt: string = '';
    storyCollections: Collection[] = [];

    // booleans
    isLoaded = false;

    // service injection
    auth = inject(AuthService);
    storyService = inject(StoryService);
    activatedRoute = inject(ActivatedRoute);
    renderer = inject(Renderer2);

    // subscription declaration
    private paramsSubscription: Subscription | undefined;
    private storySubscription: Subscription | undefined;

    ngOnInit(): void {
      setTimeout(() => {
        this.getRouteParams();

        this.subscribeToStoryServiceById();
      }, 200);

    }

    ngOnDestroy(): void {
      this.destroySubscriptions();
    }

    ngAfterViewInit(): void {

    }


    getRouteParams = () => {

      this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
        let idString = params.get('storyId');
        if(idString) {
          this.storyId = +idString;
        }
      });
    }

    subscribeToStoryServiceById = () => {

      this.storySubscription = this.storyService.find(this.storyId).subscribe({
        next: (data) => {
          this.story = data;
          this.storyCollections = data.collections;
          this.storyExcerpt = this.createIlluminatedInitial(data.excerpt);
          this.isLoaded = true;
        },
        error: (fail) => {
          console.error('Error getting story');
          console.error(fail);
        }
      });
    }

    destroySubscriptions = () => {
      if(this.paramsSubscription) {
        this.paramsSubscription.unsubscribe();
      }

      if(this.storySubscription) {
        this.storySubscription.unsubscribe();
      }
    }

    createIlluminatedInitial = (text: string): string => {
      if (text.length === 0) {
        return '';
      }

      const firstLetter = text.charAt(0);
      const restOfString = text.slice(1);

      const illuminatedInitial = `<span class="first-letter">${firstLetter}</span>`;

      let dots = ''; // Initialize dots as an empty string

      const interval = setInterval(() => {
        if (dots === '') {
          this.storyExcerpt = illuminatedInitial + restOfString; // Replace dots with restOfString
        } else {
          this.storyExcerpt = illuminatedInitial + restOfString + dots; // Add dots to the end
        }

        dots += '.'; // Add a dot in each iteration

        if (dots.length > 3) {
          dots = ''; // Reset dots to an empty string after '...'
        }
      }, 600); // Adjust the interval duration as needed (e.g., 500ms for half a second)

      return illuminatedInitial + restOfString;
    }


}
