import { User } from "./user";

export class ChatMessage {

  id?: number;
  messageContent: string;
  createdAt: string;
  chatRoom: number;
  user: { id: number; username?: string };

  constructor(
    id: number = 0,
    messageContent: string = '',
    createdAt: string = '',
    chatRoom: number = 0,
    user: { id: number; username?: string } = { id: 0, username: '' }
  ) {
    if (id) this.id = id;
    this.messageContent = messageContent;
    this.createdAt = createdAt;
    this.chatRoom = chatRoom;
    this.user = user;
  }
}
