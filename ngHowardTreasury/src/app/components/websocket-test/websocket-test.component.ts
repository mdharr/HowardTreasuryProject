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
export class WebsocketTestComponent implements OnInit {
  newMessage: string = '';
  messages: ChatMessage[] = [];

  constructor(private webSocketService: WebSocketService) {}

  ngOnInit(): void {
    this.webSocketService.getMessages().subscribe((messages: ChatMessage[]) => {
      this.messages = messages;
    });
  }

  sendMessage(): void {
    if (this.newMessage.trim() !== '') {
      // Assuming you have all necessary data to create a ChatRoom and User object.
      // If you don't have a ChatRoom or User object, you'll need to obtain them
      // or create placeholders as per your application's logic.

      // Create a placeholder ChatRoom object
      // You need to replace this with actual room data or get it from the application state
      const placeholderChatRoom = new ChatRoom(
        1, // Room ID - assuming it's already known
        'Public', // Room name
        'This is the public chat room.' // Room description
      );

      // Create a placeholder User object
      // You need to replace this with actual user data or get it from the application state
      const placeholderUser = 'Username'; // Replace with the actual username

      // Create a ChatMessage object using the new keyword
      const chatMessage = new ChatMessage(
        undefined, // No ID before creation
        this.newMessage, // The message content
        new Date().toISOString(), // Current timestamp
        placeholderChatRoom, // The associated chat room
        placeholderUser // The username of the sender
      );

      // Send the chat message using the service
      this.webSocketService.sendChatMessage(chatMessage);
      this.newMessage = ''; // Clear the input field
    }
  }
}
