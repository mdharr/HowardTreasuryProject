import { DialogService } from 'src/app/services/dialog.service';
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
  originalData: Story[] = [];
  stories: Story[] = [];
  searchQuery: string = '';
  filteredStories: Story[] = [];

  // booleans
  loading: boolean = false;
  sortTitleActive: boolean = false;
  sortFirstPublishedActive: boolean = false;
  filterCopyrightedActive: boolean = false;

  // subscriptions declarations
  private storySubscription: Subscription | undefined;

  // service injections
  auth = inject(AuthService);
  storyService = inject(StoryService);
  dialogService = inject(DialogService);

  ngOnInit(): void {

    this.storySubscription = this.storyService.indexAll().subscribe({
      next: (data) => {
        this.stories = data;
        this.originalData = data;
        this.filteredStories = data;
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
    this.filteredStories = this.filteredStories.sort((a, b) => a.title.localeCompare(b.title));
    this.sortTitleActive = true;
    this.sortFirstPublishedActive = false;
  }

  sortStoriesByFirstPublished(): void {
    this.filteredStories = this.filteredStories.sort((a, b) => new Date(a.firstPublished).getTime() - new Date(b.firstPublished).getTime());
    this.sortFirstPublishedActive = true;
    this.sortTitleActive = false;
  }

  filterByCopyrighted(): void {
    this.filteredStories = this.filteredStories.filter(story => !story.isCopyrighted);
    this.filterCopyrightedActive = true;
  }


  filterStories(): void {
    if (this.searchQuery.trim() === '') {
      // If the search query is empty, reset to the current filtered data
      this.filteredStories = [...this.originalData];
      // Reapply filters if active
      if (this.filterCopyrightedActive) {
        this.filteredStories = this.filteredStories.filter(story => !story.isCopyrighted);
      }
    } else {
      // Filter based on the current search query
      this.filteredStories = this.originalData.filter(story =>
        story.title.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      // Reapply filters if active
      if (this.filterCopyrightedActive) {
        this.filteredStories = this.filteredStories.filter(story => !story.isCopyrighted);
      }
    }
  }

  clearFilters(): void {
    // Reset all filters and restore the original data
    this.filteredStories = [...this.originalData];
    this.stories = [...this.originalData];
    this.searchQuery = '';
    this.sortTitleActive = false;
    this.sortFirstPublishedActive = false;
    this.filterCopyrightedActive = false;
  }

  openUserListDialog(story: any) {
    this.dialogService.openUserListDialog(story);
  }

}
