import { DialogService } from 'src/app/services/dialog.service';
import { BlogCommentService } from './../../services/blog-comment.service';
import { AfterViewInit, Component, inject, OnDestroy, OnInit, Renderer2, ElementRef, SecurityContext } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { BlogComment } from 'src/app/models/blog-comment';
import { BlogPost } from 'src/app/models/blog-post';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { BlogPostService } from 'src/app/services/blog-post.service';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

@Component({
  selector: 'app-blog-comments',
  templateUrl: './blog-comments.component.html',
  styleUrls: ['./blog-comments.component.css']
})
export class BlogCommentsComponent implements OnInit, OnDestroy, AfterViewInit {

    // properties
    post: BlogPost = new BlogPost;
    postId: number = 0;
    comments: BlogComment[] = [];
    replies: BlogComment[] = [];
    loggedInUser: User = new User;
    maxDepth: number = 5;
    newCommentContent: string = '';
    displayProperty: string = '';
    sanitizedContent: SafeHtml | undefined;
    postContent: string = '';
    recentPosts: BlogPost[] = [];
    commentCount: number = 0;

    editingComment: BlogComment | null = null;
    showCommentNest: boolean = true;

    // subscriptions
    private authSubscription: Subscription | undefined;
    private blogPostSubscription: Subscription | undefined;
    private recentBlogPostsSubscription: Subscription | undefined;
    private loggedInSubscription: Subscription | undefined;

    // service injections
    authService = inject(AuthService);
    blogPostService = inject(BlogPostService);
    activatedRoute = inject(ActivatedRoute);
    blogCommentService = inject(BlogCommentService);
    renderer = inject(Renderer2);
    el = inject(ElementRef);
    sanitizer = inject(DomSanitizer);
    dialogService = inject(DialogService);

    ngOnInit() {
      window.scrollTo(0, 0);
      this.subscribeToLoggedInObservable();
      this.subscribeToParams();
      this.subscribeToRecentBlogPosts();
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

    subscribeToAuth = () => {
      this.authSubscription = this.authService.getLoggedInUser().subscribe({
        next: (user) => {
          this.loggedInUser = user;
          console.log(this.loggedInUser);
        },
        error: (error) => {
          console.log('Error getting loggedInUser');
          console.log(error);
        },
      });
    }

    subscribeToLoggedInObservable() {
      this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
        this.loggedInUser = user;
      });
    }

    subscribeToBlogPost = () => {
      this.blogPostSubscription = this.blogPostService.find(this.postId).subscribe({
        next: (data) => {
          this.post = data;
          this.sanitizedContent = this.sanitizer.bypassSecurityTrustHtml(data.content);
          console.log('Post comments:', this.post.comments);
          this.comments = this.prepareCommentsForRendering(data.comments);
          this.commentCount = data.comments.length;
          console.log('Prepared comments:', this.comments);
        },
        error: (fail) => {
          console.error('Error retrieving blog post');
          console.error(fail);

        }
      });
    }

    subscribeToRecentBlogPosts = () => {
      this.recentBlogPostsSubscription = this.blogPostService.indexAll().subscribe({
        next: (data) => {
          this.recentPosts = this.sortRecentPosts(data);
        },
        error: (fail) => {
          console.error('Error retrieving recent blog posts');
          console.error(fail);
        }
      })
    }

    sortRecentPosts = (posts: BlogPost[]) => {
      let sortedPosts = posts.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
      return sortedPosts.slice(0, 10);
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

    loggedIn(): boolean {
      return this.authService.checkLogin();
    }

    openLoginDialog() {
      this.dialogService.openLoginDialog();
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
      parentComment: null,
      hidden: false
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
      id: 0,
      createdAt: '',
      user: this.loggedInUser,
      blogPost: this.post,
      replies: [],
      parentComment: parentComment,
      hidden: false
    };

    this.blogCommentService.replyToComment(parentComment.id, newReply).subscribe({
      next: (createdReply) => {
        parentComment.replies.push(createdReply);
        this.newCommentContent = '';
      },
      error: (error) => {
        console.error('Error replying to comment', error);
      },
    });
  }

  toggleCommentNestVisibility() {
    this.showCommentNest = !this.showCommentNest;
  }

  ngAfterViewInit() {

  }

  modifyHTMLContent(): SafeHtml {
    if (!this.sanitizedContent) {
      // Handle the case where sanitizedContent is null or undefined
      return '';
    }

    const sanitizedString = this.sanitizer.sanitize(SecurityContext.HTML, this.sanitizedContent);

    if (!sanitizedString) {
      // Handle the case where sanitizedString is null
      return '';
    }

    // Create a DOM element from the sanitized HTML
    const parser = new DOMParser();
    const doc = parser.parseFromString(sanitizedString, 'text/html');

    // Find all img elements and add the "post-images" class
    const imgElements = doc.querySelectorAll('img');
    imgElements.forEach((imgElement) => {
      imgElement.classList.add('post-images');
      imgElement.setAttribute('loading', 'lazy');
    });

    // Serialize the modified DOM back to HTML
    const finalModifiedContent = new XMLSerializer().serializeToString(doc);

    // Return the modified content as SafeHtml
    return this.sanitizer.bypassSecurityTrustHtml(finalModifiedContent);
  }

}
