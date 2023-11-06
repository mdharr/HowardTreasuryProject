import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private userUpdated = new Subject<User>();

  userUpdated$ = this.userUpdated.asObservable();

  updateUser(user: User) {
    this.userUpdated.next(user);
  }
}
