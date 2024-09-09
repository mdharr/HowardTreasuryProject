import { Component, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';

@Component({
  selector: 'app-book-cover',
  templateUrl: './book-cover.component.html',
  styleUrls: ['./book-cover.component.css']
})
export class BookCoverComponent implements OnInit {

  collectionsByRecommended: Collection[] = [];

  private collectionSubscription: Subscription | undefined;

  ngOnInit(): void {

  }
}
