import { HttpClient, HttpHeaders } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable, catchError, throwError, tap } from 'rxjs';
import { Buffer } from "buffer";
import { environment } from 'src/environments/environment';
import { User } from '../models/user';

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

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  // private checkLoggedInStatus() {
  //   const credentials = localStorage.getItem('credentials');
  //   if (credentials) {
  //     this.loggedIn.next(true);
  //     this.getLoggedInUser();
  //   }
  // }

  private checkLoggedInStatus() {
    const credentials = localStorage.getItem('credentials');
    if (credentials) {
      this.loggedIn.next(true);
      this.getLoggedInUser().subscribe((user) => {
        if (user && user.username) {
          this.loggedInUserSubject.next(user);
        }
      });
    }
  }

  register(user: User): Observable<User> {
    return this.http.post<User>(`${this.url}register`, user);
  }

  updateUser(user: User): Observable<User> {
    return this.http.put<User>(`${this.url}users/update`, user, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(() => new Error('AuthService.update(): error updating user: ' + err));
      })
    );
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
      tap((user) => {
        localStorage.setItem('credentials', credentials);
        this.loggedIn.next(true);
        this.loggedInUser = user;
        this.loggedInUserSubject.next(user);
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
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      },
    };
    return this.http.get<User>(this.url + 'authenticate', httpOptions).pipe(
      tap((user) => {
        if (user && user.username) {
          this.loggedInUserSubject.next(user);
        }
      }),
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('AuthService.getLoggedInUser(): error retrieving user: ' + err)
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

  verifyAccount(token: string): Observable<any> {
    return this.http.get(`${this.url}verify?token=${token}`, { responseType: 'text' });
  }

  requestPasswordReset(email: string): Observable<any> {
    return this.http.post(`${this.url}password-reset-request`, { email });
  }

  resetPassword(token: string, password: string): Observable<any> {
    return this.http.post(`${this.url}reset-password`, { token, password });
  }

}
