import { trigger, state, style, transition, animate, query, stagger } from '@angular/animations';
import { Component, ElementRef, OnInit, inject } from '@angular/core';
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

  topStories: Story[] = [];
  maxVotes: number = 0;
  // Extracted colors from the palette
  // colors: string[] = [
  //   '#3D1C1A', '#441719', '#642125', '#99261C', '#D93A24', '#E05730', '#EB7152', '#EB9380',
  //   '#EEC2B1', '#EFCA6B', '#EBE25D', '#FFD755', '#FFCA00', '#F5B620', '#C28546', '#B2887A',
  //   '#8D806A', '#7A7947', '#8C8A53', '#636138', '#495724', '#455E39', '#4D6655', '#007264',
  //   '#19887C', '#2C9C8C', '#3DA5B2', '#368F95', '#4686C8', '#3B72B4', '#5A6CB2', '#393C7A',
  //   '#372D43', '#512D3D', '#6B2845', '#B32C49', '#D13B43', '#CA3225', '#BA4C3C', '#C27964',
  //   '#DBBBA8', '#F2E2D3', '#9DA5AB', '#6B6D70', '#4A4C4D', '#38383A'
  // ];

  colors: string[] = [
    '#536168', '#333d42'
  ];

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
        if (user) {
          this.loggedInUser = user;
          this.loadUserVotes();
        }
        setTimeout(() => {
          this.loadTopStories();
        }, 500)
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

  loadTopStories() {
    this.storyService.getSortedStories().subscribe(stories => {
      if (stories) {
        this.topStories = stories.sort((a, b) => this.getVoteCount(b) - this.getVoteCount(a)).slice(0, 10);
        this.maxVotes = this.getVoteCount(this.topStories[0]);
      }
    });
  }

  getVotePercentage(story: Story): number {
    return (this.getVoteCount(story) / this.maxVotes) * 100;
  }

  getColor(index: number): string {
    return index === 0 ? this.colors[0] : this.colors[1];
    // return this.colors[index % this.colors.length];
  }

  // getColor(index: number): string {
  //   const colors = ['#ffcc00', '#66ff66', '#3399ff', '#ff6699', '#9966ff', '#ff6600', '#66ccff', '#ff9933', '#66cc99', '#ff99cc'];
  //   return colors[index % colors.length];
  // }

  upvote(story: Story, storyCard: HTMLElement): void {
    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'upvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'upvoted';
          this.scrollToStory(storyCard);
          this.resetVoteStateAfterAnimation(story.id);
        });
      } else {
        existingVote.voteType = 'upvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'upvoted';
          this.scrollToStory(storyCard);
          this.resetVoteStateAfterAnimation(story.id);
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'upvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
        this.voteState[story.id] = 'upvoted';
        this.scrollToStory(storyCard);
        this.resetVoteStateAfterAnimation(story.id);
      });
    }
  }

  downvote(story: Story, storyCard: HTMLElement): void {
    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'downvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'downvoted';
          this.scrollToStory(storyCard);
          this.resetVoteStateAfterAnimation(story.id);
        });
      } else {
        existingVote.voteType = 'downvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.loadUserVotes();
          this.voteState[story.id] = 'downvoted';
          this.scrollToStory(storyCard);
          this.resetVoteStateAfterAnimation(story.id);
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'downvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.loadUserVotes();
        this.voteState[story.id] = 'downvoted';
        this.scrollToStory(storyCard);
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

  scrollToStory(storyCard: HTMLElement) {
    setTimeout(() => {
      storyCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }, 500)
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }
}
