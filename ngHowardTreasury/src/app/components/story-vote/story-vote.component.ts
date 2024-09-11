import { Component, HostListener, OnInit, inject } from '@angular/core';
import { Color, ScaleType } from '@swimlane/ngx-charts';
import { Observable } from 'rxjs';
import { Story } from 'src/app/models/story';
import { StoryVote } from 'src/app/models/story-vote';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { StoryVoteService } from 'src/app/services/story-vote.service';
import { StoryService } from 'src/app/services/story.service';

interface ChartData {
  name: string;
  value: number;
}

@Component({
  selector: 'app-story-vote',
  templateUrl: './story-vote.component.html',
  styleUrls: ['./story-vote.component.css'],
})
export class StoryVoteComponent implements OnInit {

  allStories: Story[] = [];
  topStories: Story[] = [];
  chartData: ChartData[] = [];
  maxVotes: number = 0;
  chartMaxVotes: number = 0;
  colors: string[] = ['#262626', '#282828'];

  sortedStories$: Observable<Story[]>;
  userVotes: StoryVote[] = [];
  loggedInUser!: User;
  voteState: { [storyId: number]: string } = {};

  // ngx-charts properties
  view: [number, number] = [700, 600];
  showXAxis = true;
  showYAxis = true;
  gradient = false;
  showLegend = false;
  showXAxisLabel = true;
  xAxisLabel = 'Votes';
  showYAxisLabel = true;
  yAxisLabel = 'Stories';

  colorScheme: Color = {
    name: 'custom',
    selectable: true,
    group: ScaleType.Ordinal,
    domain: ['#303030']

  };
  // domain: ['#5AA454', '#A10A28', '#C7B42C', '#AAAAAA']

  currentPage: number = 1;
  pageSize: number = 10;
  totalPages: number = 1;

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
    this.onResize();
  }

  @HostListener('window:resize', ['$event'])
  onResize() {
    const chartContainer = document.querySelector('.poll-wrapper') as HTMLElement;
    if (chartContainer) {
      const barPadding = 16; // This should match the [barPadding] value
      const barHeight = 25; // Adjust this value for the desired bar height
      const xAxisHeight = 50; // Add extra height for x-axis labels
      const height = Math.max(400, this.topStories.length * (barHeight + barPadding) + xAxisHeight);
      this.view = [chartContainer.offsetWidth, height];
    }
  }

  subscribeToLoggedInUser() {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        if (user) {
          this.loggedInUser = user;
          this.loadUserVotes();
        }
        setTimeout(() => {
          this.loadAllStories();
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

  loadAllStories() {
    this.storyService.getSortedStories().subscribe(stories => {
      if (stories) {
        this.allStories = stories;
        this.totalPages = Math.ceil(this.allStories.length / this.pageSize);
        this.updateTopStories();
        this.updateChartData();
      }
    });
  }

  get paginatedStories(): Story[] {
    const startIndex = (this.currentPage - 1) * this.pageSize;
    return this.allStories.slice(startIndex, startIndex + this.pageSize);
  }

  nextPage() {
    if (this.currentPage < this.totalPages) {
      this.currentPage++;
    }
  }

  previousPage() {
    if (this.currentPage > 1) {
      this.currentPage--;
    }
  }

  updateTopStories() {
    this.topStories = this.allStories
      .sort((a, b) => this.getVoteCount(b) - this.getVoteCount(a))
      .slice(0, 10);
    this.maxVotes = Math.max(...this.allStories.map(s => this.getVoteCount(s)));
    this.updateChartMaxVotes();
  }

  updateChartMaxVotes() {
    const baseValue = Math.pow(10, Math.floor(Math.log10(this.maxVotes)));
    this.chartMaxVotes = Math.ceil(this.maxVotes / baseValue) * baseValue * 2;
  }

  updateChartData() {
    this.chartData = this.topStories.map(story => ({
      name: story.title,
      value: this.getVoteCount(story)
    }));
  }

  getVotePercentage(story: Story): number {
    return (this.getVoteCount(story) / this.chartMaxVotes) * 100;
  }

  getColor(index: number): string {
    return index === 0 ? this.colors[0] : this.colors[1];
  }

  upvote(story: Story, storyCard: HTMLElement): void {
    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'upvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.updateVoteAndChart(story, 'upvoted', storyCard);
        });
      } else {
        existingVote.voteType = 'upvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.updateVoteAndChart(story, 'upvoted', storyCard);
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'upvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.updateVoteAndChart(story, 'upvoted', storyCard);
      });
    }
  }

  downvote(story: Story, storyCard: HTMLElement): void {
    const existingVote = this.userVotes.find(vote => vote.story.id === story.id);

    if (existingVote) {
      if (existingVote.voteType === 'downvote') {
        this.storyVoteService.deleteVote(existingVote.id).subscribe(() => {
          this.updateVoteAndChart(story, 'downvoted', storyCard);
        });
      } else {
        existingVote.voteType = 'downvote';
        this.storyVoteService.updateVote(existingVote).subscribe(() => {
          this.updateVoteAndChart(story, 'downvoted', storyCard);
        });
      }
    } else {
      const newVote = new StoryVote(0, story, this.loggedInUser, 'downvote');
      this.storyVoteService.createVote(newVote).subscribe(() => {
        this.updateVoteAndChart(story, 'downvoted', storyCard);
      });
    }
  }

  updateVoteAndChart(story: Story, voteState: string, storyCard: HTMLElement) {
    this.loadUserVotes();
    this.voteState[story.id] = voteState;
    this.resetVoteStateAfterAnimation(story.id);
    this.updateStoryVotes(story);
    this.updateTopStories();
    this.updateChartData();
  }

  updateStoryVotes(story: Story) {
    const index = this.allStories.findIndex(s => s.id === story.id);
    if (index !== -1) {
      this.allStories[index] = { ...story };
    }
  }

  getVoteType(story: Story): string | null {
    const vote = this.userVotes.find((v) => {
      return v.story.id === story.id && v.user.id === this.loggedInUser.id;
    });
    return vote ? vote.voteType : null;
  }

  getVoteCount(story: Story): number {
    if (!story || !story.storyVotes) return 0;
    const upvotes = story.storyVotes.filter(vote => vote.voteType === 'upvote').length;
    const downvotes = story.storyVotes.filter(vote => vote.voteType === 'downvote').length;
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
