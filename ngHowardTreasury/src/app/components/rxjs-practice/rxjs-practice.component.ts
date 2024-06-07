import { Component, OnInit, inject } from '@angular/core';
import { Observable, map, filter, mergeMap, of, catchError, from, toArray, tap, take, Subscription } from 'rxjs';
import { RxjsDataService } from 'src/app/services/rxjs-data.service';

@Component({
  selector: 'app-rxjs-practice',
  templateUrl: './rxjs-practice.component.html',
  styleUrls: ['./rxjs-practice.component.css']
})
export class RxjsPracticeComponent implements OnInit {

  // properties
  data: number[] = [];

  // observables
  data$!: Observable<number[]>;
  error$!: Observable<string>;

  // subscriptions
  private dataSub: Subscription | undefined;

  private dataService = inject(RxjsDataService);

  constructor() { }

  ngOnInit(): void {
    this.data$ = this.dataService.getData().pipe(
      catchError(err => {
        this.error$ = err.message;
        return of([]);
      })
    );
  }

  // ngOnInit(): void {
  //   this.dataSub = this.dataService.getData().subscribe({
  //     next: (results: number[]) => {
  //       this.data = results;
  //     },
  //     error: (fail) => {
  //       console.log(fail);
  //     }
  //   });
  // }

  ngOnDestroy(): void {
    if (this.dataSub) {
      this.dataSub.unsubscribe();
    }
  }
}
