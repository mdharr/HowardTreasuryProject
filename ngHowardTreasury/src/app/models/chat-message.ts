import { User } from "./user";

export class ChatMessage {

  id?: number;
  messageContent: string;
  createdAt: string;
  chatRoom: number;
  user: Partial<User>;

  constructor(
    id: number = 0,
    messageContent: string = '',
    createdAt: string = '',
    chatRoom: number = 0,
    user: Partial<User> = new User()
  ) {
    if (id) this.id = id;
    this.messageContent = messageContent;
    this.createdAt = createdAt;
    this.chatRoom = chatRoom;
    this.user = user;
  }
}
