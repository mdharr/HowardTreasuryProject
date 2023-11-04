import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { BlogComment } from '../models/blog-comment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class BlogCommentService {

  private url = environment.baseUrl + 'api/comments';
  private otherUrl = environment.baseUrl + 'api/posts';

  http = inject(HttpClient);
  authService = inject(AuthService);

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authService.getLoggedInUser(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  indexAll(): Observable<BlogComment[]> {
    return this.http.get<BlogComment[]>(`${this.url}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
          new Error('BlogCommentService.indexAll(): error retrieving list of blog comments' + err)
        );
      })
    );
  }

  find(id: number): Observable<BlogComment> {
    return this.http.get<BlogComment>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
          new Error('BlogCommentService.find(): error retrieving blog comment: ' + err)
        );
      })
    );
  }

  createComment(id: number, blogComment: BlogComment): Observable<BlogComment> {
    return this.http.post<BlogComment>(`${this.otherUrl}/${id}/comments`, blogComment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
          new Error('BlogCommentService.createComment(): error creating blog comment: ' + err)
        );
      })
    );
  }

  updateComment(id: number, blogComment: BlogComment): Observable<BlogComment> {
    return this.http.put<BlogComment>(`${this.url}/${id}`, blogComment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
          new Error('BlogCommentService.updateComment(): error updating blog comment: ' + err)
        );
      })
    );
  }

  deleteComment(id: number): Observable<boolean> {
    return this.http.delete<boolean>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
          new Error('BlogCommentService.deleteComment(): error deleting blog comment: ' + err)
        );
      })
    );
  }

  replyToComment(id: number, blogComment: BlogComment): Observable<BlogComment> {
    return this.http.post<BlogComment>(`${this.url}/${id}/replies`, blogComment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
          new Error('BlogCommentService.replyToComment(): error replying to blog comment: ' + err)
        );
      })
    );
  }
}
