import { Component, inject, OnInit } from '@angular/core';
import { concatMap, filter, map, mergeMap, Subscription, tap } from 'rxjs';
import { Story } from 'src/app/models/story';
import { PersonService } from 'src/app/services/person.service';
import { StoryService } from 'src/app/services/story.service';

@Component({
  selector: 'app-stories-test',
  templateUrl: './stories-test.component.html',
  styleUrls: ['./stories-test.component.css']
})
export class StoriesTestComponent implements OnInit {

  // properties initialization
  stories: Story[] = [];
  storyTitles: string[] = [];
  copyrightedStories: Story[] = [];
  story: Story = new Story();

  // booleans declarations


  // subscriptions
  private storySubscription: Subscription | undefined;

  // service injection
  storyService = inject(StoryService);
  personService = inject(PersonService);

  ngOnInit(): void {

    // map example
    // this.storySubscription = this.storyService.indexAll().pipe(
    //   map((data) => data.map((story) => story.title))
    // ).subscribe({
    //   next: (titles) => {
    //     this.storyTitles = titles;
    //   },
    //   error: (fail) => {
    //     console.error('Error retrieving stories');
    //     console.error(fail);
    //   }
    // });

    // filter example
    // this.storySubscription = this.storyService.indexAll().subscribe({
    //   next: (data) => {
    //     // Assign the data to the component's stories property
    //     this.stories = data;

    //     // Filter the stories based on the isCopyrighted property
    //     this.copyrightedStories = this.stories.filter((story) => story.isCopyrighted === true);
    //   },
    //   error: (fail) => {
    //     console.error('Error retrieving stories');
    //     console.error(fail);
    //   }
    // });

    // tap example
    // this.storySubscription = this.storyService.indexAll().pipe(
    //   tap((data) => {
    //     console.log('Received data:', data);
    //   })
    // ).subscribe({
    //   next: (data) => {
    //     this.stories = data;
    //   },
    //   error: (fail) => {
    //     console.error('Error retrieving stories');
    //     console.error(fail);
    //   }
    // });

  }



}
