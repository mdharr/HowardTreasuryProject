import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Story } from 'src/app/models/story';
import { AuthService } from 'src/app/services/auth.service';
import { StoryService } from 'src/app/services/story.service';

@Component({
  selector: 'app-stories',
  templateUrl: './stories.component.html',
  styleUrls: ['./stories.component.css']
})
export class StoriesComponent implements OnInit, OnDestroy {

  // properties initialization
  stories: Story[] = [];

  // subscriptions declarations
  private storySubscription: Subscription | undefined;

  // service injections
  auth = inject(AuthService);
  storyService = inject(StoryService);

  ngOnInit(): void {

    this.storySubscription = this.storyService.indexAll().subscribe({
      next: (data) => {
        this.stories = data;
      },
      error:(fail) => {
        console.error('Error retrieving stories');
        console.error(fail);
      }
    });
  }

  ngOnDestroy(): void {
    if (this.storySubscription) {
      this.storySubscription.unsubscribe();
    }
  }

  sortStoriesByTitle(): void {
    this.stories.sort((a, b) => a.title.localeCompare(b.title));
  }

  sortStoriesByFirstPublished(): void {
    this.stories.sort((a, b) => new Date(a.firstPublished).getTime() - new Date(b.firstPublished).getTime());
  }

  filterByCopyrighted(): void {

  }

}
