import { trigger, state, style, transition, animate, query, stagger } from '@angular/animations';
import { Component, OnInit, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { Story } from 'src/app/models/story';
import { StoryVote } from 'src/app/models/story-vote';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { StoryVoteService } from 'src/app/services/story-vote.service';
import { StoryService } from 'src/app/services/story.service';

@Component({
  selector: 'app-story-vote',
  templateUrl: './story-vote.component.html',
  styleUrls: ['./story-vote.component.css'],
  animations: [
    trigger('storyAnimation', [
      transition('* <=> *', [
        query(':enter', [
          style({ height: '0px', opacity: 0 }),
          stagger(100, [
            animate('300ms ease-out', style({ height: '*', opacity: 1 }))
          ])
        ], { optional: true }),
        query(':leave', [
          stagger(100, [
            animate('300ms ease-in', style({ height: '0px', opacity: 0 }))
          ])
        ], { optional: true })
      ])
    ])
  ]
})
export class StoryVoteComponent implements OnInit {
  sortedStories$: Observable<Story[]>;
  userVotes: StoryVote[] = [];
  loggedInUser!: User;

  storyService = inject(StoryService);
  storyVoteService = inject(StoryVoteService);
  authService = inject(AuthService);

  constructor() {
    this.sortedStories$ = this.storyService.getSortedStories();
  }

  ngOnInit(): void {
    this.subscribeToLoggedInUser();
    this.storyService.loadStories();
  }

  subscribeToLoggedInUser() {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        this.loadUserVotes(); // Load user votes after setting the logged in user
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

  loadUserVotes(): void {
    if (this.loggedInUser.id) {
      this.storyVoteService.getVotesByUserId(this.loggedInUser.id).subscribe(votes => {
        this.userVotes = votes;
      });
    }
  }

  upvote(story: Story): void {

    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'upvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
        });
      } else {
        existingVote.voteType = 'upvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.loadUserVotes();
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'upvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
      });
    }
  }

  downvote(story: Story): void {

    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'downvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
        });
      } else {
        existingVote.voteType = 'downvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.loadUserVotes();
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'downvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
      });
    }
  }

  getVoteType(story: Story): string | null {
    const vote = this.userVotes.find((v) => {
      return v.story.id === story.id && v.user.id === this.loggedInUser.id;
    });
    return vote ? vote.voteType : null;
  }

  getVoteCount(story: Story): number {
    const upvotes = story.storyVotes?.filter(vote => vote.voteType === 'upvote').length ?? 0;
    const downvotes = story.storyVotes?.filter(vote => vote.voteType === 'downvote').length ?? 0;
    return upvotes - downvotes;
  }

  trackByStoryId(index: number, story: Story): number {
    return story.id;
  }
}
