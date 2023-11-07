import { BlogPost } from './blog-post';
import { User } from './user';
export class BlogComment {

  id: number;
  content: string;
  createdAt: string;
  updatedAt: string;
  user: User;
  blogPost: BlogPost;
  parentComment?: BlogComment | null;
  replies: BlogComment[];
  hidden: boolean;

  constructor(
    id: number = 0,
    content: string = '',
    createdAt: string = '',
    updatedAt: string = '',
    user: User = new User(),
    blogPost: BlogPost = new BlogPost(),
    parentComment: BlogComment = new BlogComment(),
    replies: BlogComment[] = [],
    hidden: boolean = false
  ) {
    this.id = id;
    this.content = content;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.user = user;
    this.blogPost = blogPost;
    this.parentComment = parentComment;
    this.replies = replies;
    this.hidden = hidden;
  }
}
