import { Component } from '@angular/core';
import { OpenAiService } from 'src/app/services/open-ai.service';

@Component({
  selector: 'app-adventure',
  templateUrl: './adventure.component.html',
  styleUrls: ['./adventure.component.css']
})
export class AdventureComponent {
  // userMessage: string = '';
  // chatHistory: { user: string, response: string }[] = [];

  userMessage: string = '';
  chatHistory: { role: string, content: string }[] = [];

  constructor(private openAiService: OpenAiService) {}

  sendMessage() {
    if (this.userMessage.trim()) {
      this.chatHistory.push({ role: 'user', content: this.userMessage });
      this.openAiService.getAdventureResponse(this.chatHistory).subscribe(
        (responseMessage) => {
          this.chatHistory.push({ role: 'assistant', content: responseMessage });
          this.userMessage = '';
        },
        (error) => {
          console.error('Error:', error);
        }
      );
    }
  }
}
