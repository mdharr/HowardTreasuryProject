import { BlogPostService } from './../../services/blog-post.service';
import { AuthService } from './../../services/auth.service';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { BlogPost } from 'src/app/models/blog-post';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-blog-posts',
  templateUrl: './blog-posts.component.html',
  styleUrls: ['./blog-posts.component.css']
})
export class BlogPostsComponent implements OnInit, OnDestroy {

  // properties
  posts: BlogPost[] = [];
  groupedPosts: { [year: number]: BlogPost[] } = {};
  loggedInUser: User = new User();

  // booleans
  showAll: boolean = true;
  showByYear: boolean = false;

  // subscriptions
  private authSubscription: Subscription | undefined;
  private blogPostSubscription: Subscription | undefined;

  // service injections
  authService = inject(AuthService);
  blogPostService = inject(BlogPostService);

  ngOnInit() {
    this.subscribeToBlogPostIndexAll();
  }

  ngOnDestroy() {
    this.destroyAllSubscriptions();
  }

  subscribeToBlogPostIndexAll = () => {
    this.blogPostSubscription = this.blogPostService.indexAll().subscribe({
      next: (data) => {
        this.posts = data;
        this.groupedPosts = this.groupBlogPostsByYear(data);
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

}
