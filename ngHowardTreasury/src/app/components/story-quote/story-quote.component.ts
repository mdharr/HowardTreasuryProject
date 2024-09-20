import { Component, OnInit } from '@angular/core';
import { StoryQuote } from 'src/app/models/story-quote';

@Component({
  selector: 'app-story-quote',
  templateUrl: './story-quote.component.html',
  styleUrls: ['./story-quote.component.css']
})
export class StoryQuoteComponent implements OnInit {

  quote: StoryQuote = new StoryQuote();
  quotes: StoryQuote[] = [];

  ngOnInit() {

  }

}
