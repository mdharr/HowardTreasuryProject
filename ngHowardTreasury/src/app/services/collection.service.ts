import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Collection } from '../models/collection';
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
    return this.http.get<Collection[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CollectionService.indexAll(): error retrieving list of collections ' + err)
        );
      })
    );
  }
}
