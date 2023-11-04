import { Component, EventEmitter, inject, Input, OnDestroy, OnInit, Output, AfterViewInit, ViewChild, ElementRef, AfterContentInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { BlogPost } from 'src/app/models/blog-post';
import { BlogPostService } from 'src/app/services/blog-post.service';

@Component({
  selector: 'app-post-recommendation',
  templateUrl: './post-recommendation.component.html',
  styleUrls: ['./post-recommendation.component.css']
})
export class PostRecommendationComponent implements OnInit, OnDestroy, AfterViewInit {
  @Input() postId: number = 0;

  isLoaded: boolean = false;
  @Output() imageLoaded: EventEmitter<void> = new EventEmitter<void>();

  // properties
  post: BlogPost = new BlogPost();

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

  ngAfterViewInit() {
    console.log('ngAfterViewInit in PostRecommendationComponent');
    this.checkImageLoaded();
  }

  checkImageLoaded() {
    const imgElement = new Image();
    imgElement.onload = () => {
      this.isLoaded = true;
      this.imageLoaded.emit();
    };
    imgElement.src = this.post.imageUrl;
  }

  subscribeToBlogPostIndexAll = () => {
    this.blogPostSubscription = this.blogPostService.find(this.postId).subscribe({
      next: (data: BlogPost) => {
        this.post = data;
        this.checkImageLoaded();
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
