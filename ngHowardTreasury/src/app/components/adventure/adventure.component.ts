import { Component } from '@angular/core';
import { OpenAiService } from 'src/app/services/open-ai.service';

@Component({
  selector: 'app-adventure',
  templateUrl: './adventure.component.html',
  styleUrls: ['./adventure.component.css']
})
export class AdventureComponent {
  userMessage: string = '';
  chatHistory: { user: string, response: string }[] = [];

  constructor(private openAiService: OpenAiService) {}

  sendMessage() {
    if (this.userMessage.trim()) {
      this.chatHistory.push({ user: 'You', response: this.userMessage });
      this.openAiService.getAdventureResponse(this.userMessage).subscribe(
        (data) => {
          this.chatHistory.push({ user: 'AI', response: data });
          this.userMessage = '';
        },
        (error) => {
          console.error('Error:', error);
        }
      );
    }
  }
}
