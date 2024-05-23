import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Story } from '../models/story';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class StoryService {

  private url = environment.baseUrl + 'api/stories';

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
}
