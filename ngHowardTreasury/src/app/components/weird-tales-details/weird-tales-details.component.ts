import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { Component, OnInit, OnDestroy, inject } from '@angular/core';
import { Subscription } from 'rxjs';
import { WeirdTales } from 'src/app/models/weird-tales';
import { WeirdTalesService } from 'src/app/services/weird-tales.service';

@Component({
  selector: 'app-weird-tales-details',
  templateUrl: './weird-tales-details.component.html',
  styleUrls: ['./weird-tales-details.component.css']
})
export class WeirdTalesDetailsComponent implements OnInit, OnDestroy {

  // properties
  weirdTalesId: number = 0;
  weirdTales: WeirdTales = new WeirdTales();

  // subscriptions declarations
  private paramsSubscription: Subscription | undefined;
  private weirdTalesSubscription: Subscription | undefined;

  // injections
  router = inject(Router);
  activatedRoute = inject(ActivatedRoute);
  weirdTalesService = inject(WeirdTalesService);

  ngOnInit() {
    this.getRouteParams();
    this.subscribeToWeirdTalesService();
  }

  ngOnDestroy(): void {
    if(this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
    if(this.weirdTalesSubscription) {
      this.weirdTalesSubscription.unsubscribe();
    }
  }

  getRouteParams() {
    this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
      let idString = params.get('weirdTalesId');
      if(idString) {
        this.weirdTalesId = +idString;
      }
    });
  }

  subscribeToWeirdTalesService() {
    this.weirdTalesSubscription = this.weirdTalesService.find(this.weirdTalesId).subscribe({
      next: (data) => {
       this.weirdTales = data;
      },
      error: (fail) => {
        console.error('Failed to index weird tales magazine objects');
        console.error(fail);
      }
    });
  }
}
