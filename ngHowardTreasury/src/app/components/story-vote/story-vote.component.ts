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
    trigger('voteAnimation', [
      state('upvoted', style({
        transform: 'scale(1.02)',
        backgroundColor: '#008001'
      })),
      state('downvoted', style({
        transform: 'scale(1.02)',
        backgroundColor: '#c13438'
      })),
      transition('* => upvoted', [
        animate('0.5s ease')
      ]),
      transition('* => downvoted', [
        animate('0.5s ease')
      ]),
      transition('upvoted => *', [
        animate('0.5s ease')
      ]),
      transition('downvoted => *', [
        animate('0.5s ease')
      ])
    ])
  ]
})
export class StoryVoteComponent implements OnInit {
  sortedStories$: Observable<Story[]>;
  userVotes: StoryVote[] = [];
  loggedInUser!: User;
  voteState: { [storyId: number]: string } = {};

  storyService = inject(StoryService);
  storyVoteService = inject(StoryVoteService);
  authService = inject(AuthService);

  constructor() {
    this.sortedStories$ = this.storyService.getSortedStories();
  }

  ngOnInit(): void {
    window.scrollTo(0, 0);
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

  // upvote(story: Story): void {

  //   const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

  //   if (existingVote) {
  //     if (existingVote.voteType === 'upvote') {
  //       this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
  //         this.loadUserVotes();
  //       });
  //     } else {
  //       existingVote.voteType = 'upvote';
  //       this.storyVoteService.updateVote(existingVote).subscribe(() => {
  //         this.loadUserVotes();
  //       });
  //     }
  //   } else {
  //     const newVote = new StoryVote(0, story, this.loggedInUser, 'upvote');
  //     this.storyVoteService.createVote(newVote).subscribe(() => {
  //       this.loadUserVotes();
  //     });
  //   }
  // }

  // downvote(story: Story): void {

  //   const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

  //   if (existingVote) {
  //     if (existingVote.voteType === 'downvote') {
  //       this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
  //         this.loadUserVotes();
  //       });
  //     } else {
  //       existingVote.voteType = 'downvote';
  //       this.storyVoteService.updateVote(existingVote).subscribe(() => {
  //         this.loadUserVotes();
  //       });
  //     }
  //   } else {
  //     const newVote = new StoryVote(0, story, this.loggedInUser, 'downvote');
  //     this.storyVoteService.createVote(newVote).subscribe(() => {
  //       this.loadUserVotes();
  //     });
  //   }
  // }

  upvote(story: Story): void {
    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'upvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'upvoted';
          this.resetVoteStateAfterAnimation(story.id);
        });
      } else {
        existingVote.voteType = 'upvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'upvoted';
          this.resetVoteStateAfterAnimation(story.id);
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'upvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
        this.voteState[story.id] = 'upvoted';
        this.resetVoteStateAfterAnimation(story.id);
      });
    }
  }

  downvote(story: Story): void {
    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'downvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'downvoted';
          this.resetVoteStateAfterAnimation(story.id);
        });
      } else {
        existingVote.voteType = 'downvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'downvoted';
          this.resetVoteStateAfterAnimation(story.id);
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'downvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
        this.voteState[story.id] = 'downvoted';
        this.resetVoteStateAfterAnimation(story.id);
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

  resetVoteStateAfterAnimation(storyId: number) {
    setTimeout(() => {
      this.voteState[storyId] = '';
    }, 300);
  }
}
