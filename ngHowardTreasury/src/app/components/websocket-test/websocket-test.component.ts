import { AuthService } from './../../services/auth.service';
import { Subscription } from 'rxjs';
import { Component, OnInit, OnDestroy } from '@angular/core';
import { ChatMessage } from 'src/app/models/chat-message';
import { WebSocketService } from 'src/app/services/websocket.service';
import { User } from 'src/app/models/user';
import { ChatRoom } from 'src/app/models/chat-room';

@Component({
  selector: 'app-websocket-test',
  templateUrl: './websocket-test.component.html',
  styleUrls: ['./websocket-test.component.css'],
})
export class WebsocketTestComponent implements OnInit, OnDestroy {
  newMessage: string = '';
  messages: ChatMessage[] = [];
  loggedInUser: User = new User();

  private loggedInSubscription: Subscription | undefined;
  private webSocketSubscription: Subscription | undefined;
  private authSubscription: Subscription | undefined;

  constructor(private webSocketService: WebSocketService, private authService: AuthService) {}

  ngOnInit(): void {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        console.log('LOGGED IN USER: ' + this.loggedInUser.id);

      },
      error: (error) => {
        console.log('Error getting loggedInUser');
        console.log(error);
      },
    });
    // this.subscribeToLoggedInObservable();
    // this.subscribeToLoggedInObservable();

    this.webSocketSubscription = this.webSocketService.getMessages().subscribe((messages: ChatMessage[]) => {
      this.messages = messages;
    });
  }

  ngOnDestroy(): void {
    if(this.loggedInSubscription) {
      this.loggedInSubscription.unsubscribe();
    }
    if(this.webSocketSubscription) {
      this.webSocketSubscription.unsubscribe();
    }
    if(this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
  }

  sendMessage(): void {
    if (this.newMessage.trim() !== '') {
      // Assuming you have a method to get the current logged-in user's ID
      // and your chat room ID is already known and fixed as '1' for the public chat room.

      // Create a new ChatMessage object with the current message content
      // and other required properties like chatRoom ID and user ID.
      const chatMessage = new ChatMessage(
        undefined, // No need to set an ID for a new message
        this.newMessage, // The message content from input
        new Date().toISOString(), // Current timestamp for createdAt
        1, // The ID for the public chat room
        this.loggedInUser.id // The ID of the logged-in user
      );

      // Send the chat message using the WebSocket service
      this.webSocketService.sendChatMessage(chatMessage);
      this.newMessage = ''; // Clear the input field after sending the message
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
}
