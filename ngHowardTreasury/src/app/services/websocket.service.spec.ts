import { TestBed } from '@angular/core/testing';
import { WebSocketService } from './websocket.service'; // Make sure the path is correct

describe('WebsocketService', () => {
  let service: WebSocketService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(WebSocketService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
