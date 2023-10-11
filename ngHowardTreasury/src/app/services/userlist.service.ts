import { HttpClient, HttpParams } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { UserList } from '../models/user-list';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserlistService {

  private url = environment.baseUrl + 'api/lists';

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
