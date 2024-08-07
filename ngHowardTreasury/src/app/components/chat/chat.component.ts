import { AuthService } from '../../services/auth.service';
import { Subscription } from 'rxjs';
import { Component, OnInit, OnDestroy, ChangeDetectorRef, ViewChild, ElementRef } from '@angular/core';
import { ChatMessage } from 'src/app/models/chat-message';
import { WebSocketService } from 'src/app/services/websocket.service';
import { User } from 'src/app/models/user';
import { ChatService } from 'src/app/services/chat.service';

@Component({
  selector: 'app-websocket-test',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css'],
})
export class ChatComponent implements OnInit, OnDestroy {
  @ViewChild('chatDisplay') private chatDisplayContainer!: ElementRef;

  newMessage: string = '';
  messages: ChatMessage[] = [];
  groupedMessages: { date: string; messages: ChatMessage[] }[] = [];
  loggedInUser: User = new User();
  chatRoomId: number = 0;

  private subscriptions: Subscription[] = [];

  constructor(
    private webSocketService: WebSocketService,
    private authService: AuthService,
    private chatService: ChatService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.subscriptions.push(
      this.authService.getLoggedInUser().subscribe({
        next: (user) => {
          this.loggedInUser = user;
        },
        error: (error) => {
          console.error('Error getting loggedInUser', error);
        },
      })
    );

    this.chatRoomId = 1;
    this.fetchChatHistory(this.chatRoomId);

    this.subscriptions.push(
      this.webSocketService.getMessages().subscribe((newMessages: ChatMessage[]) => {
        const uniqueNewMessages = newMessages.filter(newMsg =>
          !this.messages.some(existingMsg => existingMsg.id === newMsg.id)
        );

        this.messages = [...this.messages, ...uniqueNewMessages];
        this.groupMessagesByDate(this.messages);
        this.cdr.detectChanges(); // Ensure change detection is triggered
        setTimeout(() => this.scrollToBottom(), 0);
      })
    );
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(sub => sub.unsubscribe());
  }

  private scrollToBottom(): void {
    try {
      this.chatDisplayContainer.nativeElement.scrollTop = this.chatDisplayContainer.nativeElement.scrollHeight;
    } catch (err) { }
  }

  sendMessage(): void {
    if (this.newMessage.trim() !== '') {
      const user = { id: this.loggedInUser.id, username: this.loggedInUser.username }; // Assuming loggedInUser is of correct type with id and username

      const chatMessage = new ChatMessage(
        undefined, // No ID before creation
        this.newMessage, // The message content
        new Date().toISOString(), // Current timestamp
        this.chatRoomId, // Your chat room ID
        user // User object with id and username
      );

      // Send the chat message
      this.webSocketService.sendChatMessage(chatMessage);
      this.newMessage = ''; // Clear input field
      setTimeout(() => this.scrollToBottom(), 0);
    }
  }

  fetchChatHistory(chatRoomId: number): void {
    this.subscriptions.push(
      this.chatService.getChatHistory(chatRoomId).subscribe({
        next: (data) => {
          this.messages = data;
          this.sortChatHistory(this.messages);
          this.groupMessagesByDate(this.messages);
          this.cdr.detectChanges();
          setTimeout(() => this.scrollToBottom(), 0);
        },
        error: (fail) => {
          console.error('ChatService.getChatHistory: failed to fetch chat history', fail);
        }
      })
    );
  }

  sortChatHistory = (messages: ChatMessage[]) => {
    let sortedMessages = messages.sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime());
    return sortedMessages;
  }

  groupMessagesByDate(messages: ChatMessage[]): void {
    const groups = messages.reduce((acc, message) => {
      const date = new Date(message.createdAt).toDateString();
      if (!acc[date]) {
        acc[date] = [];
      }
      acc[date].push(message);
      return acc;
    }, {} as { [date: string]: ChatMessage[] });

    this.groupedMessages = Object.keys(groups).map(date => ({
      date: date,
      messages: groups[date].sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime())
    }));
  }
}
