import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { BlogPost } from 'src/app/models/blog-post';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { BlogPostService } from 'src/app/services/blog-post.service';

@Component({
  selector: 'app-recent-posts',
  templateUrl: './recent-posts.component.html',
  styleUrls: ['./recent-posts.component.css']
})
export class RecentPostsComponent implements OnInit, OnDestroy {
  // properties
  posts: BlogPost[] = [];
  recentPosts: BlogPost[] = [];
  loggedInUser: User = new User();

  // booleans
  showAll: boolean = true;
  showByYear: boolean = false;

  // subscriptions
  private blogPostSubscription: Subscription | undefined;

  // service injections
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
        this.recentPosts = this.sliceRecentPosts(this.posts);
      },
      error: (fail) => {
        console.error('Error retrieving blog posts');
        console.error(fail);
      }
    });
  }

  destroyAllSubscriptions = () => {
    if(this.blogPostSubscription) {
      this.blogPostSubscription.unsubscribe();
    }
  }

  sliceRecentPosts(posts: BlogPost[]) {
    let originalPosts = posts;
    let slicedPosts =  originalPosts.slice(originalPosts.length-4, originalPosts.length);
    return slicedPosts.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
  }

  scrollToTop() {
    window.scrollTo(0, 0);
  }
}
