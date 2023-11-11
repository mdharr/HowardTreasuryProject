
export class ChatMessage {

  id?: number;
  messageContent: string;
  createdAt: string;
  chatRoom: number;
  user: number;

  constructor(
    id: number = 0,
    messageContent: string = '',
    createdAt: string = '',
    chatRoom: number = 0,
    user: number = 0
  ) {
    if (id) this.id = id;
    this.messageContent = messageContent;
    this.createdAt = createdAt;
    this.chatRoom = chatRoom;
    this.user = user;
  }
}
