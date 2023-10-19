import { Component, EventEmitter, Input, Output } from '@angular/core';
import { BlogComment } from 'src/app/models/blog-comment';

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
    replyToComment() {
      this.reply.emit(this.comment);
    }
}
