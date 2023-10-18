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
  loggedInUser: User = new User();

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

}
