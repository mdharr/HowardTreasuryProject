import { BlogCommentService } from './../../services/blog-comment.service';
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
    newCommentContent: string = ''

    editingComment: BlogComment | null = null;

    // subscriptions
    private authSubscription: Subscription | undefined;
    private blogPostSubscription: Subscription | undefined;

    // service injections
    authService = inject(AuthService);
    blogPostService = inject(BlogPostService);
    activatedRoute = inject(ActivatedRoute);
    blogCommentService = inject(BlogCommentService);

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

      // Method to create a new comment
  createComment() {
    const newComment: BlogComment = {
      content: this.newCommentContent,
      id: 0,
      createdAt: '',
      user: this.loggedInUser,
      blogPost: this.post,
      replies: [],
      parentComment: null
    };

    this.blogCommentService.createComment(this.postId, newComment).subscribe({
      next: (createdComment) => {
        // Add the newly created comment to the comments array
        this.comments.push(createdComment);
        this.newCommentContent = ''; // Clear the input field
      },
      error: (error) => {
        console.error('Error creating comment', error);
      },
    });
  }

  // Method to update a comment
  updateComment(comment: BlogComment) {
    this.blogCommentService.updateComment(comment.id, comment).subscribe({
      next: (updatedComment) => {
        // Update the comment in the comments array
        const index = this.comments.findIndex((c) => c.id === updatedComment.id);
        if (index !== -1) {
          this.comments[index] = updatedComment;
        }
        this.editingComment = null; // Clear the editingComment
      },
      error: (error) => {
        console.error('Error updating comment', error);
      },
    });
  }

  // Method to delete a comment
  deleteComment(comment: BlogComment) {
    this.blogCommentService.deleteComment(comment.id).subscribe({
      next: (deleted) => {
        if (deleted) {
          // Remove the comment from the comments array
          this.comments = this.comments.filter((c) => c.id !== comment.id);
        }
      },
      error: (error) => {
        console.error('Error deleting comment', error);
      },
    });
  }

  // Method to reply to a comment
  replyToComment(parentComment: BlogComment) {
    const newReply: BlogComment = {
      content: this.newCommentContent,
      id: 0, // Provide an appropriate ID, or let the backend assign it
      createdAt: '', // Provide a timestamp, or let the backend assign it
      user: this.loggedInUser, // Assign the user who is creating the reply
      blogPost: this.post, // Assign the current blog post
      replies: [], // Initialize the replies array as an empty array
      parentComment: parentComment, // Set the parent comment
      // Add other required properties based on your application's logic
    };

    this.blogCommentService.replyToComment(parentComment.id, newReply).subscribe({
      next: (createdReply) => {
        // Add the newly created reply to the parent comment's replies array
        parentComment.replies.push(createdReply);
        this.newCommentContent = ''; // Clear the input field
      },
      error: (error) => {
        console.error('Error replying to comment', error);
      },
    });
  }

}
