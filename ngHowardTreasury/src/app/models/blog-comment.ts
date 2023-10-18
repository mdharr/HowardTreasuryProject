import { BlogPost } from './blog-post';
import { User } from './user';
export class BlogComment {

  id: number;
  content: string;
  createdAt: string;
  user: User;
  blogPost: BlogPost;
  parentComment: BlogComment;
  replies: BlogComment[];

  constructor(
    id: number = 0,
    content: string = '',
    createdAt: string = '',
    user: User = new User(),
    blogPost: BlogPost = new BlogPost(),
    parentComment: BlogComment = new BlogComment(),
    replies: BlogComment[] = []
  ) {
    this.id = id;
    this.content = content;
    this.createdAt = createdAt;
    this.user = user;
    this.blogPost = blogPost;
    this.parentComment = parentComment;
    this.replies = replies;
  }
}
