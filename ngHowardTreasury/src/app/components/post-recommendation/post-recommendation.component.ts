import { Component, inject, Input, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { BlogPost } from 'src/app/models/blog-post';
import { BlogPostService } from 'src/app/services/blog-post.service';

@Component({
  selector: 'app-post-recommendation',
  templateUrl: './post-recommendation.component.html',
  styleUrls: ['./post-recommendation.component.css']
})
export class PostRecommendationComponent implements OnInit, OnDestroy {
  @Input() postId: number = 0;

  // properties
  post: BlogPost = new BlogPost();

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
    this.blogPostSubscription = this.blogPostService.find(this.postId).subscribe({
      next: (data: BlogPost) => {
        this.post = data;
      },
      error: (fail) => {
        console.error('Error retrieving blog post');
        console.error(fail);

      }
    });
  }

  destroyAllSubscriptions = () => {
    if(this.blogPostSubscription) {
      this.blogPostSubscription.unsubscribe();
    }
  }
}
