import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { ChatMessage } from '../models/chat-message';
import * as Stomp from 'webstomp-client';
import SockJS from 'sockjs-client';

@Injectable({
  providedIn: 'root'
})
export class WebSocketService {
  private stompClient: any;
  private messages: BehaviorSubject<ChatMessage[]>;

  constructor() {
    this.messages = new BehaviorSubject<ChatMessage[]>([]);
    this.initializeWebSocketConnection();
  }

  private initializeWebSocketConnection(): void {
    // Create a new SockJS instance with the endpoint defined in Spring Boot
    const socket = new SockJS('http://localhost:8093/ws');
    // Create a STOMP client over the SockJS instance
    this.stompClient = Stomp.over(socket);

    // Connect to the STOMP client
    this.stompClient.connect({}, (frame: any) => {
      // Subscribe to the public chat room
      this.stompClient.subscribe('/topic/publicChatRoom', (sdkEvent: any) => {
        this.onMessageReceived(sdkEvent);
      });
    }, this.onError);
  }

  public sendChatMessage(chatMessage: ChatMessage): void {
    console.log('Sending message:', JSON.stringify(chatMessage)); // Add this line
    this.stompClient.send('/app/chat.sendMessage', JSON.stringify(chatMessage));
  }

  private onMessageReceived(sdkEvent: any): void {
    // Parse the incoming message and update the messages BehaviorSubject
    const message: ChatMessage = JSON.parse(sdkEvent.body);
    this.messages.next([...this.messages.getValue(), message]);
  }

  private onError(error: string): void {
    // Handle connection error
    console.error(`WebSocket Error: ${error}`);
  }

  public getMessages(): Observable<ChatMessage[]> {
    return this.messages.asObservable();
  }
}
