import { BlogComment } from "./blog-comment";
import { User } from "./user";

export class BlogPost {

  id: number;
  title: string;
  content: string;
  createdAt: string;
  user: User;
  comments: BlogComment[];
  hidden: boolean;

  constructor(
    id: number = 0,
    title: string = '',
    content: string = '',
    createdAt: string = '',
    user: User = new User(),
    comments: BlogComment[] = [],
    hidden: boolean = false
  ) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.createdAt = createdAt;
    this.user = user;
    this.comments = comments;
    this.hidden = hidden;
  }
}
