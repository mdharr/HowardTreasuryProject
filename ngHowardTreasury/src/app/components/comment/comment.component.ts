import { BlogCommentService } from './../../services/blog-comment.service';
import { Component, EventEmitter, inject, Input, Output } from '@angular/core';
import { BlogComment } from 'src/app/models/blog-comment';
import { BlogPost } from 'src/app/models/blog-post';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css']
})
export class CommentComponent {
  @Input() comment!: BlogComment;
  @Input() replyDepth: number = 0;
  @Input() maxDepth: number = 5;

  newCommentContent: string = '';
  showReplyInput: boolean = false;
  newReplyContent: string = '';

  post: BlogPost = new BlogPost;
  postId: number = 0;
  loggedInUser: User = new User;

  blogCommentService = inject(BlogCommentService);

    // Events to emit actions to the parent component
    @Output() edit = new EventEmitter<BlogComment>();
    @Output() delete = new EventEmitter<BlogComment>();
    @Output() reply = new EventEmitter<BlogComment>();

    // Method to handle the edit button click
    editComment() {
      this.edit.emit(this.comment);
    }

    // Method to handle the delete button click
    deleteComment() {
      this.delete.emit(this.comment);
    }

    // Method to handle the reply button click
    // replyToComment() {
    //   this.reply.emit(this.comment);
    // }

    toggleReplyInput() {
      this.showReplyInput = !this.showReplyInput;
    }

    replyToComment(parentComment: BlogComment) {
      const newReply: BlogComment = {
        content: this.newReplyContent,
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
          this.newReplyContent = ''; // Clear the input field
          this.toggleReplyInput();
        },
        error: (error) => {
          console.error('Error replying to comment', error);
        },
      });
    }
}
