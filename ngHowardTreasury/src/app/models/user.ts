import { ChatMessage } from "./chat-message";
import { ChatRoom } from "./chat-room";
import { UserList } from "./user-list";

export class User {
  id: number;
  username: string;
  password: string;
  confirmPassword: string;
  enabled: boolean;
  role: string;
  email: string;
  imageUrl: string;
  userLists: UserList[];
  chatRooms?: ChatRoom[];
  chatMessages?: ChatMessage[];

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    confirmPassword: string = '',
    enabled: boolean = false,
    role: string = '',
    email: string = '',
    imageUrl: string = '',
    userLists: UserList[] = []
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.confirmPassword = confirmPassword;
    this.enabled = enabled;
    this.role = role;
    this.email = email;
    this.imageUrl = imageUrl;
    this.userLists = userLists;
  }
}
