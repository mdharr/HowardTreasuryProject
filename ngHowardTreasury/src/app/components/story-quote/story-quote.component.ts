import { Story } from './../../models/story';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { StoryQuote } from 'src/app/models/story-quote';
import { StoryQuoteService } from 'src/app/services/story-quote.service';

@Component({
  selector: 'app-story-quote',
  templateUrl: './story-quote.component.html',
  styleUrls: ['./story-quote.component.css']
})
export class StoryQuoteComponent implements OnInit, OnDestroy {

  quote: StoryQuote = new StoryQuote();
  quotes: StoryQuote[] = [];

  storyQuoteSubscription: Subscription | undefined;

  storyQuoteService = inject(StoryQuoteService);

  ngOnInit() {
    this.subscribeToStoryQuotes();
  }

  ngOnDestroy() {
    if (this.storyQuoteSubscription) {
      this.storyQuoteSubscription.unsubscribe();
    }
  }

  subscribeToStoryQuotes() {
    this.storyQuoteSubscription = this.storyQuoteService.indexAll().subscribe({
      next: (data) => {
        this.quotes = data;
      },
      error: (err) => {
        console.error("Error subscribing to story quote service" + err);
      }
    });
  }

}
