import { ChatRoom } from "./chat-room";
import { User } from "./user";

export class ChatMessage {
  id?: number;
  messageContent: string;
  createdAt: string;
  chatRoom: ChatRoom;
  user: string;

  constructor(
    id: number = 0,
    messageContent: string = '',
    createdAt: string = '',
    chatRoom: ChatRoom = new ChatRoom(),
    user: string = ''
  ) {
    if (id) this.id = id;
    this.messageContent = messageContent;
    this.createdAt = createdAt;
    this.chatRoom = chatRoom;
    this.user = user;
  }
}
