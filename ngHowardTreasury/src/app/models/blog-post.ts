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
  imageUrl: string;

  constructor(
    id: number = 0,
    title: string = '',
    content: string = '',
    createdAt: string = '',
    user: User = new User(),
    comments: BlogComment[] = [],
    hidden: boolean = false,
    imageUrl: string = ''
  ) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.createdAt = createdAt;
    this.user = user;
    this.comments = comments;
    this.hidden = hidden;
    this.imageUrl = imageUrl;
  }
}
