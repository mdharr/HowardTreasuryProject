import { ChatMessage } from "./chat-message";
import { User } from "./user";

export class ChatRoom {
  id: number;
  name: string;
  description: string;
  owner: User;
  users: User[];
  chatMessages: ChatMessage[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    owner: User = new User(),
    users: User[] = [],
    chatMessages: ChatMessage[] = []
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.owner = owner;
    this.users = users;
    this.chatMessages = chatMessages;
  }
}
