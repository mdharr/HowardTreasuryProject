import { Component, Input } from '@angular/core';
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
}
