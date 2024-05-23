import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Illustrator } from '../models/illustrator';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class IllustratorService {

  private url = environment.baseUrl + 'api/illustrators';

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

  indexAll(): Observable<Illustrator[]> {
    return this.http.get<Illustrator[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
          new Error('IllustratorService.indexAll(): error retrieving list of illustrators' + err)
        );
      })
    );
  }

  find(id: number): Observable<Illustrator> {
    return this.http.get<Illustrator>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
          new Error('IllustratorService.find(): error retrieving illustrator: ' + err)
        );
      })
    );
  }
}
