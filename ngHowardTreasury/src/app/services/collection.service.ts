import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Collection } from '../models/collection';
import { CollectionWithStoriesDTO } from '../models/collection-with-stories-dto';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class CollectionService {
  private url = environment.baseUrl + 'api/collections';

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

  indexAll(): Observable<Collection[]> {
    return this.http.get<Collection[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CollectionService.indexAll(): error retrieving list of collections ' + err)
        );
      })
    );
  }

  find(id: number): Observable<Collection> {
    return this.http.get<Collection>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CollectionService.find(): error retrieving collection: ' + err)
        );
      })
    );
  }

  findCollectionWithStoriesById(id: number): Observable<CollectionWithStoriesDTO> {
    return this.http.get<CollectionWithStoriesDTO>(`${this.url}/${id}/pages`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('CollectionService.findCollectionWithStoriesById(): error retrieving collection with stories: ' + err)
        );
      })
    );
  }

}
