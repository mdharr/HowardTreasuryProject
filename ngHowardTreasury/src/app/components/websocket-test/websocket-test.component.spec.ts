import { ComponentFixture, TestBed } from '@angular/core/testing';

import { WebsocketTestComponent } from './websocket-test.component';

describe('WebsocketTestComponent', () => {
  let component: WebsocketTestComponent;
  let fixture: ComponentFixture<WebsocketTestComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [WebsocketTestComponent]
    });
    fixture = TestBed.createComponent(WebsocketTestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
