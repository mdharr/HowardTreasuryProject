import { BlogPostService } from './../../services/blog-post.service';
import { AuthService } from './../../services/auth.service';
import { Component, inject, OnDestroy, OnInit, AfterViewInit, ElementRef, Renderer2 } from '@angular/core';
import { Subscription } from 'rxjs';
import { BlogPost } from 'src/app/models/blog-post';
import { User } from 'src/app/models/user';
import { trigger, state, style, transition, animate, keyframes, query, stagger } from '@angular/animations';

@Component({
  selector: 'app-blog-posts',
  templateUrl: './blog-posts.component.html',
  styleUrls: ['./blog-posts.component.css'],
  animations: [
    trigger('customEasingAnimation', [
      transition(':enter', [
        query('.post-wrapper', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(50, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ]
})
export class BlogPostsComponent implements OnInit, OnDestroy, AfterViewInit {

  // properties
  posts: BlogPost[] = [];
  groupedPosts: { [year: number]: BlogPost[] } = {};
  postsCreatedAsc: BlogPost[] = [];
  postsCreatedDesc: BlogPost[] = [];
  postsTitleAsc: BlogPost[] = [];
  postsTitleDesc: BlogPost[] = [];
  loggedInUser: User = new User();

  // booleans
  showAll: boolean = false;
  showByYear: boolean = false;
  showByCreatedAsc: boolean = false;
  showByCreatedDesc: boolean = false;
  showByTitleAsc: boolean = false;
  showByTitleDesc: boolean = false;
  displayOption: string = 'all';

  // subscriptions
  private authSubscription: Subscription | undefined;
  private blogPostSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;

  // service injections
  authService = inject(AuthService);
  blogPostService = inject(BlogPostService);
  el = inject(ElementRef);
  renderer = inject(Renderer2);

  ngOnInit() {
    window.scrollTo(0, 0);
    this.subscribeToLoggedInObservable();
    this.subscribeToBlogPostIndexAll();

    this.triggerCustomEasingAnimation();
    this.addCustomStyles();
  }

  ngOnDestroy() {
    this.destroyAllSubscriptions();
  }

  ngAfterViewInit() {

  }

  addCustomStyles() {
    const style = document.createElement('style');
    style.innerHTML = `
      .custom-expansion-header .mat-expansion-indicator::after {
        color: var(--black_white) !important;
      }
    `;
    document.head.appendChild(style);
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
    });
  }

  subscribeToBlogPostIndexAll = () => {
    this.blogPostSubscription = this.blogPostService.indexAll().subscribe({
      next: (data) => {
        this.posts = data;
        this.groupedPosts = this.groupBlogPostsByYear(data);
        this.postsCreatedAsc = this.sortByCreatedAsc(data);
        this.postsCreatedDesc = this.sortByCreatedDesc(data);
        this.postsTitleAsc = this.sortByTitleAsc(data);
        this.postsTitleDesc = this.sortByTitleDesc(data);
      },
      error: (fail) => {
        console.error('Error retrieving blog posts');
        console.error(fail);

      }
    });
  }

  destroyAllSubscriptions = () => {
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
    if(this.blogPostSubscription) {
      this.blogPostSubscription.unsubscribe();
    }
    if(this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
  }

  groupBlogPostsByYear(posts: BlogPost[]): { [year: number]: BlogPost[] } {
    const groupedPosts: { [year: number]: BlogPost[] } = {};

    for (const post of posts) {
      const year = new Date(post.createdAt).getFullYear();
      if (!groupedPosts[year]) {
        groupedPosts[year] = [];
      }
      groupedPosts[year].push(post);
    }

    return groupedPosts;
  }

  getSortedYears(): number[] {
    return Object.keys(this.groupedPosts)
      .map((year) => parseInt(year))
      .sort((a, b) => b - a); // Sort in descending order (most recent first)
  }

  sortByCreatedAsc(posts: BlogPost[]) {
    return [...posts].sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime());
  }

  sortByCreatedDesc(posts: BlogPost[]) {
    return [...posts].sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
  }

  sortByTitleAsc(posts: BlogPost[]) {
    return [...posts].sort((a, b) => a.title.localeCompare(b.title));
  }

  sortByTitleDesc(posts: BlogPost[]) {
    return [...posts].sort((a, b) => b.title.localeCompare(a.title));
  }

  toggleShowAll() {
    if(this.showAll) {
      this.showAll = false;
      this.showByYear = true;
    }
    else {
      this.showAll = true;
      this.showByYear = false;
    }
  }

  toggleDisplayOption(selectedOption: string) {
    // Reset all options to false
    this.showAll = false;
    this.showByYear = false;
    this.showByCreatedAsc = false;
    this.showByCreatedDesc = false;
    this.showByTitleAsc = false;
    this.showByTitleDesc = false;

    // Set the selected option to true
    switch (selectedOption) {
      case 'all':
        this.showAll = true;
        break;
      case 'year':
        this.showByYear = true;
        break;
      case 'created_asc':
        this.showByCreatedAsc = true;
        break;
      case 'created_desc':
        this.showByCreatedDesc = true;
        break;
      case 'title_asc':
        this.showByTitleAsc = true;
        break;
      case 'title_desc':
        this.showByTitleDesc = true;
        break;
      default:
        this.showAll = true;
        break;
    }
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

  triggerCustomEasingAnimation() {
    // You can use a timeout to trigger the animation after a short delay
    setTimeout(() => {
      this.showAll = true; // Set the showAll to true to trigger the animation
    }, 200);
  }

}
