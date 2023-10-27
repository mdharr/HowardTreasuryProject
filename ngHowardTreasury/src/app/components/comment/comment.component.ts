import { BlogCommentService } from './../../services/blog-comment.service';
import { Component, EventEmitter, inject, Input, Output, OnInit } from '@angular/core';
import { BlogComment } from 'src/app/models/blog-comment';
import { BlogPost } from 'src/app/models/blog-post';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { CdkTextareaAutosize } from '@angular/cdk/text-field';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css'],
})
export class CommentComponent implements OnInit {
  @Input() comment!: BlogComment;
  @Input() replyDepth: number = 0;
  @Input() maxDepth: number = 5;

  newCommentContent: string = '';
  showReplyInput: boolean = false;
  newReplyContent: string = '';
  showEditInput: boolean = false;
  newUpdateContent: string = '';

  post: BlogPost = new BlogPost();
  postId: number = 0;
  loggedInUser: User = new User();

  blogCommentService = inject(BlogCommentService);
  authService = inject(AuthService);

  // Events to emit actions to the parent component
  @Output() edit = new EventEmitter<BlogComment>();
  @Output() delete = new EventEmitter<BlogComment>();
  @Output() reply = new EventEmitter<BlogComment>();

  ngOnInit() {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;

      },
      error: (error) => {
        console.log('Error getting loggedInUser');
        console.log(error);
      },
    });
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }

  toggleReplyInput() {
    this.showReplyInput = !this.showReplyInput;
    this.showEditInput = false;
  }

  toggleEditInput() {
    this.showEditInput = !this.showEditInput;
    this.showReplyInput = false;
  }

  replyToComment(parentComment: BlogComment) {
    const newReply: BlogComment = {
      content: this.newReplyContent,
      id: 0,
      createdAt: '',
      user: this.loggedInUser,
      blogPost: this.post,
      replies: [],
      parentComment: parentComment,
      hidden: false
    };

    this.blogCommentService
      .replyToComment(parentComment.id, newReply)
      .subscribe({
        next: (createdReply) => {
          // Add the newly created reply to the parent comment's replies array
          parentComment.replies.push(createdReply);
          this.newReplyContent = ''; // Clear the input field
          this.toggleReplyInput();
        },
        error: (error) => {
          console.error('Error replying to comment', error);
        },
      });
  }

  // Modify the editComment method to update the content property:
  editComment(comment: BlogComment) {
    // Set newUpdateContent to the current content of the comment
    this.newUpdateContent = comment.content;

    // Show the edit input field
    this.showEditInput = true;
  }

  cancelEdit = () => {
    this.showEditInput = false;
    this.newUpdateContent = '';
  }

  // Modify the submitEdit method to update the comment's content property:
  submitEdit() {
    // Update the content property of the comment
    this.comment.content = this.newUpdateContent;

    // Call the updateComment service method
    this.blogCommentService
      .updateComment(this.comment.id, this.comment)
      .subscribe({
        next: (updatedComment) => {
          // Optionally, you can hide the edit input field and clear newUpdateContent
          this.showEditInput = false;
          this.newUpdateContent = '';
        },
        error: (error) => {
          console.error('Error updating comment', error);
        },
      });
  }

  deleteComment() {
    this.blogCommentService.deleteComment(this.comment.id).subscribe({
      next: (data) => {
        console.log('Comment deleted!');

      },
      error: (fail) => {
        console.error('Comment deletion unsuccessful: ' + fail);

      }
    });
  }

  cancelReply = () => {
    this.showReplyInput = false;
    this.newReplyContent = '';
  }
}
