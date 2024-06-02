import { AfterViewChecked, AfterViewInit, Component, ElementRef, OnDestroy, OnInit, ViewChild, inject } from '@angular/core';
import { Subscription } from 'rxjs';
import { OpenAiService } from 'src/app/services/open-ai.service';
import { typeText } from 'src/app/utils/typing-util';

@Component({
  selector: 'app-adventure',
  templateUrl: './adventure.component.html',
  styleUrls: ['./adventure.component.css']
})
export class AdventureComponent implements OnInit, AfterViewInit, AfterViewChecked, OnDestroy {

  userMessage: string = '';
  chatHistory: { role: string, content: string }[] = [];
  loading: boolean = false;
  typingIndex: number = -1;
  typingText: string = '';
  introText: string = `You find yourself in the dimly lit interior of the Dusky Coil Inn, a bustling hub for exiles in Sepermeru, a city dominated by Relic Hunters. The tavern is bustling with many mercenaries and adventurers from different walks of life drinking, playing games, and sharing hushed tales of their endeavors in these treacherous Exile Lands, all while, in another corner, a minstrel's lute and haunting melody fill the air. To your left, at the end of a long, weathered wooden bar, a wiry Stygian man with darting eyes tends to patrons beneath a sign reading "Ale: 1 Silver."`;

  private subscriptions: Subscription[] | undefined;

  @ViewChild('chatHistoryContainer') private chatHistoryContainer!: ElementRef;

  private openAiService = inject(OpenAiService);

  ngOnInit(): void {
    this.chatHistory.push({ role: 'AI', content: '' });
    this.startTypingEffect(this.introText, this.chatHistory.length - 1);
  }

  ngAfterViewInit() {
    this.scrollToBottom();
  }

  ngAfterViewChecked() {
    this.scrollToBottom();
  }

  ngOnDestroy() {
    if(this.subscriptions && this.subscriptions.length > 0) {
      this.subscriptions.forEach(subscription => subscription.unsubscribe());
    }
  }

  sendMessage() {
    if (this.userMessage.trim()) {
      this.chatHistory.push({ role: 'user', content: this.userMessage });
      this.loading = true;

      // Filter out only user messages
      const userMessages = this.chatHistory.filter(chat => chat.role === 'user');

      // Log messages for debugging
      console.log('Sending messages:', JSON.stringify(userMessages));
      this.userMessage = '';
      this.subscriptions?.push(this.openAiService.getAdventureResponse(userMessages).subscribe(
        (responseMessage: string) => {
          this.chatHistory.push({ role: 'assistant', content: '' });
          const lastIndex = this.chatHistory.length - 1;
          this.startTypingEffect(responseMessage, lastIndex);
          this.userMessage = '';
          this.loading = false;
        },
        (error: any) => {
          console.error('Error:', error);
          this.loading = false;
        },
        () => {
          console.log('Chat message processed.');
        }
      ));
    }
  }

  private scrollToBottom(): void {
    try {
      this.chatHistoryContainer.nativeElement.scrollTop = this.chatHistoryContainer.nativeElement.scrollHeight;
    } catch (err) {
      console.error('Could not scroll to bottom:', err);
    }
  }

  private startTypingEffect(text: string, index: number): void {
    this.typingIndex = index;
    this.chatHistory[index].content = '';
    let charIndex = 0;

    const typeCharacter = () => {
      if (charIndex < text.length) {
        this.chatHistory[index].content += text.charAt(charIndex);
        charIndex++;
        setTimeout(typeCharacter, 5);
      } else {
        this.typingIndex = -1;
        this.scrollToBottom();
      }
    };

    typeCharacter();
  }

}
