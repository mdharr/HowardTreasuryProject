import { Injectable } from '@angular/core';
import { Observable, of, delay, map } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class RxjsDataService {

  numbers: number[] = [1,2,3,4,5,6,7,8,9,10];

  constructor() { }

  // getData(): Observable<number[]> {
  //   return of(this.numbers);
  // }

  getData(): Observable<number[]> {
    return of(this.numbers).pipe(
      map(numbers => {
        if (numbers.length > 0) {
          return numbers.map(number => number * 3)
                        .filter(number => number >= 10);
        } else {
          throw new Error('No data available');
        }
      }),
      delay(2000)
    );
  }
}
