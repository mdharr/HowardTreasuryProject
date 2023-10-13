import { HttpClient, HttpParams } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, catchError, Observable, of, switchMap, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { UserList } from '../models/user-list';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserlistService {

  private url = environment.baseUrl + 'api/lists';

  private userListsSubject = new BehaviorSubject<UserList[]>([]);
  userLists$ = this.userListsSubject.asObservable();

  http = inject(HttpClient);
  authService = inject(AuthService);

  constructor() {
    this.loadUserLists();
  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authService.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  getAllUserLists(): Observable<UserList[]> {
    return this.http.get<UserList[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('UserListService.getAllUserLists(): error retrieving userlists ' + err)
        );
      })
    );
  }

  private loadUserLists() {
    // Fetch user lists and update the subject
    // Replace this with your actual HTTP request to get user lists
    this.http.get<UserList[]>(this.url, this.getHttpOptions()).subscribe(
      (userLists) => {
        this.userListsSubject.next(userLists);
      },
      (error) => {
        console.error('Error loading user lists:', error);
      }
    );
  }

  createUserList(userList: UserList): Observable<UserList> {
    return this.http.post<UserList>(this.url, userList, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'UserListService.createUserList(): error creating userlist ' + err
            )
        );
      }),
      switchMap((createdUserList) => {
        // After creating the user list, update the user lists subject
        const currentLists = this.userListsSubject.value;
        const updatedLists = [...currentLists, createdUserList];
        this.userListsSubject.next(updatedLists);
        return of(createdUserList);
      })
    );
  }

  removeItemsFromUserList(listId: number, itemsToRemove: any): Observable<UserList> {
    return this.http.post<UserList>(`${this.url}/${listId}/removeItems`, itemsToRemove, this.getHttpOptions()).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError(
          () =>
            new Error('UserListService.removeItemsFromUserList(): error removing items from user list ' + error)
        );
      })
    );
  }

  addObjectToUserLists(objectId: number, objectType: string, userListIds: number[]): Observable<UserList[]> {
    // Construct the query parameters
    const params = new HttpParams()
      .set('objectId', objectId.toString())
      .set('objectType', objectType)
      .set('userListIds', userListIds.join(',')); // Convert the array to a comma-separated string

    return this.http.post<UserList[]>(`${this.url}/addItems`, null, {
      params: params,
      ...this.getHttpOptions(), // Include any other headers or options you need
    }).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError(
          () =>
            new Error('UserListService.addObjectToUserLists(): error adding object to user lists ' + error)
        );
      })
    );
  }

}
