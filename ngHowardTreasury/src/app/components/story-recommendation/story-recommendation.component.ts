import { Component, OnDestroy, OnInit, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Story } from 'src/app/models/story';
import { StoryService } from 'src/app/services/story.service';

@Component({
  selector: 'app-story-recommendation',
  templateUrl: './story-recommendation.component.html',
  styleUrls: ['./story-recommendation.component.css']
})
export class StoryRecommendationComponent implements OnInit, OnDestroy {

  stories: Story[] = [];
  recommendedStory: Story = new Story();

  storyRequested: boolean = false;

  private storySubscription!: Subscription | null;

  storyService = inject(StoryService);
  router = inject(Router);

  ngOnInit() {
    this.subscribeToStories();
  }

  ngOnDestroy() {
    this.storySubscription?.unsubscribe();
  }

  subscribeToStories() {
    this.storySubscription = this.storyService.indexAll().subscribe({
      next: (data) => {
        this.stories = [...data.filter(story => story.excerpt)];
      },
      error:(fail) => {
        console.error('Error retrieving stories');
        console.error(fail);
      }
    });
  }

  chooseYourOwnStory() {
    const random = this.findRandomNumber(this.stories);
    const story = this.stories[random];
    return story;
  }

  findRandomNumber(storyArr: Story[]) {
    return Math.floor(Math.random() * storyArr.length);
  }

  recommendStory() {
    this.storyRequested = false;
    const story = this.chooseYourOwnStory();
    if (story) {
      this.recommendedStory = story;
      this.storyRequested = true;
      this.router.navigate(['/stories', this.recommendedStory.id]);
    } else {
      console.error('No story found');
      this.recommendedStory = new Story();
    }
  }
}
