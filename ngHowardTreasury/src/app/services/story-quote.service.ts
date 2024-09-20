import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Story } from '../models/story';
import { StoryQuote } from '../models/story-quote';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class StoryQuoteService {

  private url = environment.baseUrl + 'api/quotes';

  private storiesSubject = new BehaviorSubject<Story[]>([]);
  stories$ = this.storiesSubject.asObservable();

  http = inject(HttpClient);
  authService = inject(AuthService);

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  indexAll(): Observable<StoryQuote[]> {
    return this.http.get<StoryQuote[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('StoryService.indexAll(): error retrieving list of stories ' + err)
        );
      })
    );
  }

  private getCredentials(): string | null {
    return localStorage.getItem('credentials');
  }
}
