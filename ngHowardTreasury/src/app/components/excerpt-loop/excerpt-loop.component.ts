import { StoryService } from './../../services/story.service';
import { Story } from './../../models/story';
import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-excerpt-loop',
  templateUrl: './excerpt-loop.component.html',
  styleUrls: ['./excerpt-loop.component.css']
})
export class ExcerptLoopComponent implements OnInit, OnDestroy {

  ngOnInit() {

  }

  ngOnDestroy() {

  }

}
