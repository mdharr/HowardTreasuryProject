import { Component, inject } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { BlogComment } from 'src/app/models/blog-comment';
import { BlogPost } from 'src/app/models/blog-post';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { BlogPostService } from 'src/app/services/blog-post.service';

@Component({
  selector: 'app-blog-comments',
  templateUrl: './blog-comments.component.html',
  styleUrls: ['./blog-comments.component.css']
})
export class BlogCommentsComponent {

    // properties
    post: BlogPost = new BlogPost;
    postId: number = 0;
    comments: BlogComment[] = [];
    replies: BlogComment[] = [];
    loggedInUser: User = new User;
    maxDepth: number = 5;

    // subscriptions
    private authSubscription: Subscription | undefined;
    private blogPostSubscription: Subscription | undefined;

    // service injections
    authService = inject(AuthService);
    blogPostService = inject(BlogPostService);
    activatedRoute = inject(ActivatedRoute);

    ngOnInit() {
      this.subscribeToParams();

    }

    ngOnDestroy() {
      this.destroyAllSubscriptions();
    }

    subscribeToParams = () => {
      this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
        let idString = params.get('postId');
        if(idString) {
          this.postId = +idString;
          this.subscribeToBlogPost();
        }
      });
    }

    subscribeToBlogPost = () => {
      this.blogPostSubscription = this.blogPostService.find(this.postId).subscribe({
        next: (data) => {
          this.post = data;
          console.log('Post comments:', this.post.comments);
          this.comments = this.prepareCommentsForRendering(data.comments);
          console.log('Prepared comments:', this.comments);
        },
        error: (fail) => {
          console.error('Error retrieving blog post');
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

    prepareCommentsForRendering(comments: BlogComment[]): BlogComment[] {
      const preparedComments: BlogComment[] = [];

      // Create a map for quick access
      const commentMap = new Map<number, BlogComment>();

      // Group comments by parentCommentId
      comments.forEach(comment => {
        comment.replies = [];
        commentMap.set(comment.id, comment);

        if (!comment.parentComment) {
          preparedComments.push(comment);
        } else {
          const parentComment = commentMap.get(comment.parentComment.id);
          if (parentComment) {
            parentComment.replies.push(comment);
          }
        }
      });

      return preparedComments;
    }

}
