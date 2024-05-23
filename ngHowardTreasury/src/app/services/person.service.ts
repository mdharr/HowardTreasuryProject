import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Person } from '../models/person';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PersonService {

  private url = environment.baseUrl + 'api/persons';

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

  indexAll(): Observable<Person[]> {
    return this.http.get<Person[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('PersonService.indexAll(): error retrieving list of persons ' + err)
        );
      })
    );
  }

  find(id: number): Observable<Person> {
    return this.http.get<Person>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('PersonService.find(): error retrieving person: ' + err)
        );
      })
    );
  }
}
