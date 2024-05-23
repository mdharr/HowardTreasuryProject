import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Collection } from '../models/collection';
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
        console.error(err);
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
        console.error(err);
        return throwError(
          () =>
            new Error('PoemService.find(): error retrieving poem: ' + err)
        );
      })
    );
  }

  findCollectionsByPoemId(id: number): Observable<Collection[]> {
    return this.http.get<Collection[]>(`${this.url}/${id}/collection`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('PoemService.findCollectionsByPoemId(): error retrieving collections: ' + err)
        );
      })
    );
  }
}
