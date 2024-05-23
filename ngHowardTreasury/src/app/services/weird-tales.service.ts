import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { WeirdTales } from '../models/weird-tales';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class WeirdTalesService {

  private url = environment.baseUrl + 'api/weird-tales';

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

  indexAll(): Observable<WeirdTales[]> {
    return this.http.get<WeirdTales[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('WeirdTalesService.indexAll(): error retrieving list of weird tales objects ' + err)
        );
      })
    );
  }

  find(id: number): Observable<WeirdTales> {
    return this.http.get<WeirdTales>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('WeirdTalesService.find(): error retrieving weird tales object: ' + err)
        );
      })
    );
  }
}
