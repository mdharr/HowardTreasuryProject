import { HttpClient } from '@angular/common/http';
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

  // getUserList(listId: number): Observable<UserList> {
  //   // Implement code to get a specific user list by ID from the backend
  // }

  // createUserList(userList: UserList): Observable<UserList> {
  //   // Implement code to create a new user list on the backend
  // }

  // updateUserList(listId: number, userList: UserList): Observable<UserList> {
  //   // Implement code to update a user list on the backend
  // }

  // deleteUserList(listId: number): Observable<void> {
  //   // Implement code to delete a user list by ID on the backend
  // }

  // addStoryToList(listId: number, storyId: number): Observable<void> {
  //   // Implement code to add a story to a user list on the backend
  // }

  // removeStoryFromList(listId: number, storyId: number): Observable<void> {
  //   // Implement code to remove a story from a user list on the backend
  // }

  // addPoemToList(listId: number, poemId: number): Observable<void> {
  //   // Implement code to add a poem to a user list on the backend
  // }

  // removePoemFromList(listId: number, poemId: number): Observable<void> {
  //   // Implement code to remove a poem from a user list on the backend
  // }

  // addMiscellaneaToList(listId: number, miscellaneaId: number): Observable<void> {
  //   // Implement code to add a miscellanea to a user list on the backend
  // }

  // removeMiscellaneaFromList(listId: number, miscellaneaId: number): Observable<void> {
  //   // Implement code to remove a miscellanea from a user list on the backend
  // }
}
