import { AuthService } from '../../services/auth.service';
import { Subscription } from 'rxjs';
import { Component, OnInit, OnDestroy, inject, ChangeDetectorRef, ViewChild, ElementRef, AfterViewChecked } from '@angular/core';
import { ChatMessage } from 'src/app/models/chat-message';
import { WebSocketService } from 'src/app/services/websocket.service';
import { User } from 'src/app/models/user';
import { ChatRoom } from 'src/app/models/chat-room';
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
  chatHistory: ChatMessage[] = [];
  groupedMessages: { date: string; messages: ChatMessage[] }[] = [];
  loggedInUser: User = new User();
  chatRoomId: number = 0;
  waveText: string | undefined;

  private loggedInUserSubscription: Subscription | undefined;
  private loggedInSubscription: Subscription | undefined;
  private webSocketSubscription: Subscription | undefined;
  private authSubscription: Subscription | undefined;
  private chatHistorySubscription: Subscription | undefined;

  private webSocketService = inject(WebSocketService);
  private authService = inject(AuthService);
  private chatService = inject(ChatService);

  ngOnInit(): void {
    this.loggedInUserSubscription = this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        console.log('LOGGED IN USER: ' + this.loggedInUser.id);

      },
      error: (error) => {
        console.log('Error getting loggedInUser');
        console.log(error);
      },
    });
    this.chatRoomId = 1;
    this.fetchChatHistory(this.chatRoomId);

    // Subscribe to new messages via WebSocket
    this.webSocketSubscription = this.webSocketService.getMessages().subscribe((newMessages: ChatMessage[]) => {
      // Filter out messages that are already present
      const uniqueNewMessages = newMessages.filter(newMsg =>
        !this.messages.some(existingMsg => existingMsg.id === newMsg.id));

      // Merge unique new messages with the existing messages
      this.messages = [...this.messages, ...uniqueNewMessages];
      this.groupMessagesByDate(this.messages);
      setTimeout(() => this.scrollToBottom(), 0);
    });

  }

  ngOnDestroy(): void {
    if(this.loggedInUserSubscription) {
      this.loggedInUserSubscription.unsubscribe();
    }
    if(this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
    if(this.webSocketSubscription) {
      this.webSocketSubscription.unsubscribe();
    }
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
    if(this.chatHistorySubscription) {
      this.chatHistorySubscription.unsubscribe();
    }
  }

  private scrollToBottom(): void {
    try {
      this.chatDisplayContainer.nativeElement.scrollTop = this.chatDisplayContainer.nativeElement.scrollHeight;
    } catch(err) { }
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

  subscribeToAuth = () => {
    this.authSubscription = this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        console.log(this.loggedInUser);
      },
      error: (error) => {
        console.log('Error getting loggedInUser');
        console.log(error);
      },
    });
  }

  subscribeToLoggedInObservable() {
    this.loggedInSubscription = this.authService.loggedInUser$.subscribe((user) => {
      this.loggedInUser = user;
      console.log('LOGGED IN USER: ' + this.loggedInUser);

    });
  }

  fetchChatHistory(chatRoomId: number) {
    this.chatHistorySubscription = this.chatService.getChatHistory(chatRoomId).subscribe({
      next: (data) => {
        this.messages = data;
        this.sortChatHistory(this.messages);
        this.groupMessagesByDate(data);
        setTimeout(() => this.scrollToBottom(), 0);
      },
      error: (fail) => {
        console.error('ChatService.getChatHistory: failed to fetch chat history', fail);
      }
    });
  }
  sortChatHistory = (messages: ChatMessage[]) => {
    let sortedMessages = messages.sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime());
    return sortedMessages;
  }
  groupMessagesByDate(messages: ChatMessage[]) {
    const groups = messages.reduce((acc, message) => {
      // Extract just the date part of the 'createdAt' field
      const date = new Date(message.createdAt).toDateString();
      if (!acc[date]) {
        acc[date] = [];
      }
      acc[date].push(message);
      return acc;
    }, {} as { [date: string]: ChatMessage[] });

    // Convert the 'groups' object to an array for Angular's *ngFor
    this.groupedMessages = Object.keys(groups).map(date => ({
      date: date,
      messages: groups[date].sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime())
    }));
  }

  animateText() {
    // It's best to not use 'DOMContentLoaded' inside Angular lifecycle because Angular takes care of when the DOM is ready. Instead, use Angular's lifecycle hooks like 'ngOnInit'.

    // Ensure waveText is not null before proceeding
    const waveText = document.querySelector('.wave');
    if (waveText) {
        // Since textContent is always a string, the null-conditional operator is not required here.
        // If textContent is null or undefined, it will not proceed to replace operation.
        const textContent = waveText.textContent || ''; // Fallback to empty string if null
        waveText.innerHTML = textContent.replace(/\S/g, "<span>$&</span>");

        // Add a hover event listener to the 'wave' class element
        waveText.addEventListener('mouseover', () => {
            // Ensure waveText is not null and querySelectorAll is called on a non-null value
            let spans = waveText.querySelectorAll('span');
            // Apply the animation delay to each span
            spans.forEach((span, index) => {
                span.style.animationDelay = `${index * 0.1}s`;
            });
        });

        // Remove the animation when not hovering
        waveText.addEventListener('mouseout', () => {
            let spans = waveText.querySelectorAll('span');
            spans.forEach((span) => {
                span.style.animationDelay = '0s';
            });
        });
    }
  }

}
