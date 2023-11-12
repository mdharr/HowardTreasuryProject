import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { ChatMessage } from '../models/chat-message';
import * as Stomp from 'webstomp-client';
import SockJS from 'sockjs-client';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class WebSocketService {

  private url = environment.baseUrl;

  private stompClient: any;
  private messages: BehaviorSubject<ChatMessage[]>;

  httpClient = inject(HttpClient);

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

  sendChatMessage(chatMessage: ChatMessage): void {
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

  // public fetchChatHistory(chatRoomId: number): Observable<ChatMessage[]> {
  //   // Implement an HTTP GET request to fetch the chat history
  //   // Replace `http://api.yourdomain.com/chatroom/${chatRoomId}/history` with your actual API endpoint
  //   return this.httpClient.get<ChatMessage[]>(`${this.url}/chatroom/${chatRoomId}/history`);
  // }

}
