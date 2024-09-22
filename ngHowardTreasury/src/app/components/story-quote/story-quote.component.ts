import { AfterViewInit, Component, ElementRef, inject, OnChanges, OnDestroy, OnInit, SimpleChanges, ViewChild } from '@angular/core';
import { Subscription } from 'rxjs';
import { StoryQuote } from 'src/app/models/story-quote';
import { StoryQuoteService } from 'src/app/services/story-quote.service';
import { fisherYatesShuffle } from 'src/app/utils/shuffle';
import { typeText } from 'src/app/utils/typing-util';

@Component({
  selector: 'app-story-quote',
  templateUrl: './story-quote.component.html',
  styleUrls: ['./story-quote.component.css']
})
export class StoryQuoteComponent implements OnInit, OnDestroy, AfterViewInit, OnChanges {
  @ViewChild('quoteContent', { static: false }) quoteContent!: ElementRef;
  @ViewChild('quoteSource') quoteSource!: ElementRef;

  quote: StoryQuote | null = null;
  quotes: StoryQuote[] = [];
  shuffledQuotes: StoryQuote[] = [];

  isTyping: boolean = false;

  storyQuoteSubscription: Subscription | undefined;

  storyQuoteService = inject(StoryQuoteService);

  typerUtil = typeText;

  ngOnInit() {
    this.subscribeToStoryQuotes();
  }

  ngOnDestroy() {
    if (this.storyQuoteSubscription) {
      this.storyQuoteSubscription.unsubscribe();
    }
  }

  ngOnChanges(changes: SimpleChanges) {
    if (changes['quote'] && !changes['quote'].firstChange) {
      this.typeQuote();
    }
  }

  ngAfterViewInit() {
    if (this.quote) {
      this.typeQuote();
    }
  }

  private subscribeToStoryQuotes() {
    this.storyQuoteSubscription = this.storyQuoteService.indexAll().subscribe({
      next: (data) => {
        this.quotes = data;
        this.shuffledQuotes = fisherYatesShuffle(this.quotes);
        this.updateQuote();
      },
      error: (err) => {
        console.error("Error subscribing to story quote service", err);
      }
    });
  }

  protected updateQuote() {
    if (this.isTyping) return;

    const poppedQuote = this.shuffledQuotes.pop();
    if (poppedQuote) {
      this.quote = poppedQuote;
      this.typeQuote();
      this.triggerBurnReveal();
    } else {
      this.shuffledQuotes = fisherYatesShuffle(this.quotes);
      this.updateQuote();
    }
  }

  private typeQuote() {
    if (this.quote && this.quoteContent) {
      this.isTyping = true;
      this.quoteContent.nativeElement.innerHTML = '';
      typeText(
        this.quoteContent.nativeElement,
        this.quote.content,
        50,
        () => {
          this.isTyping = false;
        }
      );
    } else if (this.quote) {
      setTimeout(() => this.typeQuote(), 0);
    }
  }

  private triggerBurnReveal() {
    if (this.quoteContent) {
      const element = this.quoteContent.nativeElement.querySelector('.reveal-text');
      element.style.animation = 'none';
      element.offsetHeight; // Trigger reflow
      element.style.animation = null;
    }
  }

}
