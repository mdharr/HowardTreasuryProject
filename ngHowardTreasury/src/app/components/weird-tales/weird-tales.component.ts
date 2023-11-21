import { WeirdTalesService } from './../../services/weird-tales.service';
import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { WeirdTales } from 'src/app/models/weird-tales';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-weird-tales',
  templateUrl: './weird-tales.component.html',
  styleUrls: ['./weird-tales.component.css']
})
export class WeirdTalesComponent implements OnInit, OnDestroy {

  // properties
  weirdTales: WeirdTales[] = [];
  weirdTalesImages: string[] = [];

  // subscriptions declarations
  private weirdTalesSubscription: Subscription | undefined;

  // injections
  router = inject(Router);
  weirdTalesService = inject(WeirdTalesService);

  ngOnInit() {
    this.subscribeToWeirdTalesService();
  }

  ngOnDestroy(): void {
    if(this.weirdTalesSubscription) {
      this.weirdTalesSubscription.unsubscribe();
    }
  }

  subscribeToWeirdTalesService() {
    this.weirdTalesSubscription = this.weirdTalesService.indexAll().subscribe({
      next: (data) => {
        this.weirdTales = data;
        this.weirdTalesImages = data.slice(7).map(tale => tale.imageUrl);
      },
      error: (fail) => {
        console.error('Failed to index weird tales magazine objects');
        console.error(fail);
      }
    });
  }

}
