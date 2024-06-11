import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable, catchError, map, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Story } from '../models/story';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class StoryService {

  private url = environment.baseUrl + 'api/stories';

  private storiesSubject = new BehaviorSubject<Story[]>([]);
  stories$ = this.storiesSubject.asObservable();

  http = inject(HttpClient);
  authService = inject(AuthService);

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authService.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  indexAll(): Observable<Story[]> {
    return this.http.get<Story[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('StoryService.indexAll(): error retrieving list of stories ' + err)
        );
      })
    );
  }

  find(id: number): Observable<Story> {
    return this.http.get<Story>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('StoryService.find(): error retrieving story: ' + err)
        );
      })
    );
  }

  loadStories(): void {
    this.http.get<Story[]>(this.url).subscribe(stories => {
      this.storiesSubject.next(stories);
    });
  }

  getSortedStories(): Observable<Story[]> {
    return this.stories$.pipe(
      map(stories => {
        return stories.sort((a, b) => {
          const votesA = a.storyVotes ? a.storyVotes : [];
          const votesB = b.storyVotes ? b.storyVotes : [];

          const scoreA = votesA.filter(vote => vote.voteType === 'upvote').length -
                         votesA.filter(vote => vote.voteType === 'downvote').length;
          const scoreB = votesB.filter(vote => vote.voteType === 'upvote').length -
                         votesB.filter(vote => vote.voteType === 'downvote').length;
          return scoreB - scoreA;
        });
      })
    );
  }

}
