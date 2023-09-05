import { HttpClient, HttpHeaders } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable, catchError, throwError, tap } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private url = environment.baseUrl;

  private loggedInUserSubject: BehaviorSubject<User> = new BehaviorSubject<User>(new User());
  private loggedInUser: User = new User();

  private isLoggedIn = false; // flag to track authentication state

  userId: number = 0; // User ID property

  private loggedInSubject: BehaviorSubject<boolean> = new BehaviorSubject<boolean>(false);
  private loggedIn = new BehaviorSubject<boolean>(false);
  loggedIn$ = this.loggedInSubject.asObservable();

  http = inject(HttpClient);

  register(user: User): Observable<User> {
    // Create POST request to register a new account
    return this.http.post<User>(this.url + 'register', user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('AuthService.register(): error registering user.')
        );
      })
    );
  }

  login(username: string, password: string): Observable<User> {
    // Make credentials
    const credentials = this.generateBasicAuthCredentials(username, password);
    // Send credentials as Authorization header specifying Basic HTTP authentication
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest',
      }),
    };

    // Create GET request to authenticate credentials
    return this.http.get<User>(this.url + 'authenticate', httpOptions).pipe(
      tap((newUser) => {
        // While credentials are stored in browser localStorage, we consider
        // ourselves logged in.
        localStorage.setItem('credentials', credentials);
        this.isLoggedIn = true;
        this.loggedIn.next(true);
        localStorage.setItem('isLoggedIn', 'true');
        this.loggedInUser = newUser; // store the logged-in user object
        this.loggedInUserSubject.next(this.loggedInUser); // emit the logged-in user object using the BehaviorSubject
        return newUser;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('AuthService.login(): error logging in user.')
        );
      })
    );
  }

  logout(): Observable<any> {
    localStorage.removeItem('credentials');
    localStorage.removeItem('isLoggedIn');
    localStorage.clear();
    return this.http.post(this.url + 'logout', null).pipe(
      tap(() => {
        // set isLoggedIn to false in localStorage
        this.loggedIn.next(false);
        this.loggedInUser = new User(); // clear the logged-in user object
        this.loggedInUserSubject.next(this.loggedInUser); // emit null to indicate no logged-in user using the BehaviorSubject
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('AuthService.logout(): error logging out user.')
        );
      })
    );
  }

  getLoggedInUser(): Observable<User> {
    if (!this.checkLogin()) {
      return throwError(() => {
        new Error('Not logged in.');
      });
    }
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      },
    };
    return this.http
      .get<User>(this.url + 'authenticate', httpOptions)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error( 'AuthService.getUserById(): error retrieving user: ' + err )
          );
        })
      );
  }

  isAuthenticated() {
    // Check isLoggedIn flag and local storage or cookie
    return this.isLoggedIn || localStorage.getItem('isLoggedIn') === 'true';
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

  // Setter for user ID
  setUserId(userId: number): void {
    this.userId = userId;
  }

  // Getter for user ID
  getUserId(): number {
    return this.userId;
  }

  setLoggedIn(loggedIn: boolean): void {
    this.loggedInSubject.next(loggedIn);
  }

  getCurrentLoggedInUser(): BehaviorSubject<User> {
    return this.loggedInUserSubject;
  }
}
