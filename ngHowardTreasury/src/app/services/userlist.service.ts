import { HttpClient, HttpParams } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { BehaviorSubject, catchError, concatMap, Observable, of, switchMap, tap, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { UserList } from '../models/user-list';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserlistService {

  private url = environment.baseUrl + 'api/lists';

  userListsSubject: BehaviorSubject<UserList[]> = new BehaviorSubject<UserList[]>([]);
  userLists$ = this.userListsSubject.asObservable();

  http = inject(HttpClient);
  authService = inject(AuthService);

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  getAllUserLists(): Observable<UserList[]> {
    return this.http.get<UserList[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('UserListService.getAllUserLists(): error retrieving userlists ' + err)
        );
      })
    );
  }

  loadUserLists() {
    this.http.get<UserList[]>(this.url, this.getHttpOptions()).pipe(
      catchError((error) => {
        if (error.status === 404) {
          // Handle 404 error by returning an empty list
          return of([]);
        } else {
          // Handle other errors
          console.error('Error loading user lists:', error);
          // You can choose to re-throw the error here if needed.
          return throwError('Error loading user lists');
        }
      })
    ).subscribe((userLists) => {
      this.userListsSubject.next(userLists);
    });
  }

  clearUserLists() {
    this.userListsSubject.next([]);
  }

  createUserList(userList: UserList): Observable<UserList> {
    return this.http.post<UserList>(this.url, userList, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
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

  deleteUserList(listId: number): Observable<number> {
    return this.http.delete<UserList>(`${this.url}/${listId}`, this.getHttpOptions()).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError(
          () =>
            new Error('UserListService.deleteUserList(): error deleting user list ' + error)
        );
      }),
      switchMap(() => {
        // After deleting the user list, update the user lists subject
        const currentLists = this.userListsSubject.value;
        const updatedLists = currentLists.filter(list => list.id !== listId);
        this.userListsSubject.next(updatedLists);
        return of(listId); // You can return the ID of the deleted list or null if you prefer.
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
    const params = new HttpParams()
      .set('objectId', objectId.toString())
      .set('objectType', objectType)
      .set('userListIds', userListIds.join(','));

    return this.http.post<UserList[]>(`${this.url}/addItems`, null, {
      params: params,
      ...this.getHttpOptions(),
    }).pipe(
      catchError((error: any) => {
        console.error(error);
        return throwError(
          () =>
            new Error('UserListService.addObjectToUserLists(): error adding object to user lists ' + error)
        );
      }),
      concatMap(updatedUserLists => {
        // After successfully adding the object, update the user lists subject
        this.userListsSubject.next(updatedUserLists);
        return of(updatedUserLists);
      })
    );
  }

  fetchUserLists(): Observable<UserList[]> {
    return this.http.get<UserList[]>(`${this.url}`, {
      ...this.getHttpOptions(),
    }).pipe(
      tap((userLists) => {
        this.userListsSubject.next(userLists);
      }),
      catchError((error: any) => {
        console.error(error);
        return throwError(
          () => new Error('UserListService.fetchUserLists(): error fetching user lists ' + error)
        );
      })
    );
  }

  private getCredentials(): string | null {
    return localStorage.getItem('credentials');
  }
}
