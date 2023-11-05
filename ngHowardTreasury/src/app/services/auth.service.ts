import { HttpClient, HttpHeaders } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable, catchError, throwError, tap } from 'rxjs';
import { Buffer } from "buffer";
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { UserlistService } from './userlist.service';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private url = environment.baseUrl;

  // logged in user subject
  private loggedInUserSubject: BehaviorSubject<User> = new BehaviorSubject<User>(new User());
  private loggedInUser: User = new User();
  loggedInUser$ = this.loggedInUserSubject.asObservable();

  // logged in subject
  private loggedInSubject: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);
  private loggedIn = new BehaviorSubject<boolean>(false);
  loggedIn$ = this.loggedInSubject.asObservable();

  constructor(private http: HttpClient) {
    this.checkLoggedInStatus();
  }

  private checkLoggedInStatus() {
    const credentials = localStorage.getItem('credentials');
    if (credentials) {
      this.loggedIn.next(true);
      this.getLoggedInUser();
    }
  }

  // private fetchLoggedInUser() {
  //   return this.http.get<User>(`${this.url}authenticate`).subscribe({
  //     next: (newUser) => {
  //       this.loggedInUser = newUser;
  //       this.loggedInUserSubject.next(newUser);
  //     },
  //     error: (error) => {
  //       console.log(error);
  //     }
  //   });
  // }

  register(user: User): Observable<User> {
    return this.http.post<User>(`${this.url}register`, user);
  }

  login(username: string, password: string): Observable<User> {
    const credentials = this.generateBasicAuthCredentials(username, password);
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest',
      }),
    };

    return this.http.get<User>(`${this.url}authenticate`, httpOptions).pipe(
      tap((newUser) => {
        localStorage.setItem('credentials', credentials);
        this.loggedIn.next(true);
        this.loggedInUser = newUser;
        this.loggedInUserSubject.next(newUser);
      })
    );
  }

  logout(): Observable<void> {
    localStorage.clear();
    this.loggedIn.next(false);
    this.loggedInUser = new User();
    this.loggedInUserSubject.next(this.loggedInUser);

    return this.http.post<void>(`${this.url}logout`, {});
  }

  getLoggedInUser(): Observable<User> {
    // if (!this.checkLogin()) {
    //   return throwError(() => {
    //     new Error('Not logged in.');
    //   });
    // }
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      },
    };
    return this.http.get<User>(this.url + 'authenticate', httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error( 'AuthService.getUserById(): error retrieving user: ' + err )
        );
      })
    );
  }

  checkLogin(): boolean {
    if (localStorage.getItem('credentials')) {
      return true;
    }
    return false;
  }

  generateBasicAuthCredentials(username: string, password: string): string {
    return Buffer.from(`${username}:${password}`).toString('base64');
  }

  getCredentials(): string | null {
    return localStorage.getItem('credentials');
  }

  getCurrentLoggedInUser(): BehaviorSubject<User> {
    return this.loggedInUserSubject;
  }

}
