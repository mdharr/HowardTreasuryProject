import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Poem } from '../models/poem';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PoemService {

  private url = environment.baseUrl + 'api/poems';

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

  indexAll(): Observable<Poem[]> {
    return this.http.get<Poem[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('PoemService.indexAll(): error retrieving list of poems ' + err)
        );
      })
    );
  }

  find(id: number): Observable<Poem> {
    return this.http.get<Poem>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('PoemService.find(): error retrieving poem: ' + err)
        );
      })
    );
  }
}
