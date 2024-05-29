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
  private url = environment.baseUrl + 'ws';
  private stompClient: any;
  private messages = new BehaviorSubject<ChatMessage[]>([]);

  httpClient = inject(HttpClient);

  constructor() {
    this.initializeWebSocketConnection();
  }

  private initializeWebSocketConnection(): void {
    const socket = new SockJS(this.url);
    this.stompClient = Stomp.over(socket, { protocols: ['v12.stomp'] });

    this.stompClient.connect({}, (frame: any) => {
      console.log('Connected to WebSocket server:', frame); // Debugging log
      this.stompClient.subscribe('/topic/publicChatRoom', (sdkEvent: any) => {
        this.onMessageReceived(sdkEvent);
      });
    }, this.onError);
  }

  sendChatMessage(chatMessage: ChatMessage): void {
    this.stompClient.send('/app/chat.sendMessage', JSON.stringify(chatMessage));
    console.log('Chat message sent:', chatMessage); // Debugging log
  }

  private onMessageReceived(sdkEvent: any): void {
    const message: ChatMessage = JSON.parse(sdkEvent.body);
    console.log('Message received from WebSocket:', message); // Debugging log
    const currentMessages = this.messages.getValue();
    this.messages.next([...currentMessages, message]);
  }

  private onError(error: string): void {
    console.error(`WebSocket Error: ${error}`);
  }

  public getMessages(): Observable<ChatMessage[]> {
    return this.messages.asObservable();
  }

  public setInitialMessages(messages: ChatMessage[]): void {
    this.messages.next(messages);
  }
}
