import { Component, OnInit, inject } from '@angular/core';
import { Story } from 'src/app/models/story';
import { StoryVote } from 'src/app/models/story-vote';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { StoryVoteService } from 'src/app/services/story-vote.service';
import { StoryService } from 'src/app/services/story.service';

@Component({
  selector: 'app-story-vote',
  templateUrl: './story-vote.component.html',
  styleUrls: ['./story-vote.component.css']
})
export class StoryVoteComponent implements OnInit {
  stories: Story[] = [];
  userVotes: StoryVote[] = [];
  loggedInUser: User = new User();

  storyService = inject(StoryService);
  storyVoteService = inject(StoryVoteService);
  authService = inject(AuthService);

  constructor() {}

  ngOnInit(): void {
    this.subscribeToLoggedInUser();
    this.loadStories();
    this.loadUserVotes();
  }

  subscribeToLoggedInUser() {
    this.authService.loggedInUser$.subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

  loadStories(): void {
    this.storyService.indexAll().subscribe(stories => {
      this.stories = stories;
    });
  }

  loadUserVotes(): void {
    this.storyVoteService.getVotesByUserId(this.loggedInUser.id).subscribe(votes => {
      this.userVotes = votes;
    });
  }

  upvote(story: Story): void {
    const existingVote = this.userVotes.find(vote => vote.storyId === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'upvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
        });
      } else {
        existingVote.voteType = 'upvote';
        this.storyVoteService.createVote(existingVote).subscribe(() => {
          this.loadUserVotes();
        });
      }
    } else {
      const newVote = new StoryVote(0, story.id, this.loggedInUser.id, 'upvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
      });
    }
  }

  downvote(story: Story): void {
    const existingVote = this.userVotes.find(vote => vote.storyId === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'downvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
        });
      } else {
        existingVote.voteType = 'downvote';
        this.storyVoteService.createVote(existingVote).subscribe(() => {
          this.loadUserVotes();
        });
      }
    } else {
      const newVote = new StoryVote(0, story.id, this.loggedInUser.id, 'downvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
      });
    }
  }

  getVoteType(story: Story): string | null {
    const vote = this.userVotes.find(v => v.storyId === story.id);
    return vote ? vote.voteType : null;
  }
}
