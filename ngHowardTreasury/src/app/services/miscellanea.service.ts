import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Miscellanea } from '../models/miscellanea';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class MiscellaneaService {

  private url = environment.baseUrl + 'api/miscellaneas';

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

  indexAll(): Observable<Miscellanea[]> {
    return this.http.get<Miscellanea[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('MiscellaneaService.indexAll(): error retrieving list of miscellanea ' + err)
        );
      })
    );
  }

  find(id: number): Observable<Miscellanea> {
    return this.http.get<Miscellanea>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('MiscellaneaService.find(): error retrieving miscellanea: ' + err)
        );
      })
    );
  }
}
