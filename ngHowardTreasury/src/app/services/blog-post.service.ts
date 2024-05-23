import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { BlogPost } from '../models/blog-post';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class BlogPostService {
  private url = environment.baseUrl + 'api/posts';

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

  indexAll(): Observable<BlogPost[]> {
    return this.http.get<BlogPost[]>(`${this.url}`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
          new Error('BlogPostService.indexAll(): error retrieving list of blog posts' + err)
        );
      })
    );
  }

  find(id: number): Observable<BlogPost> {
    return this.http.get<BlogPost>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
          new Error('BlogPostService.find(): error retrieving blog post: ' + err)
        );
      })
    );
  }

  createPost(post: BlogPost): Observable<BlogPost> {
    return this.http.post<BlogPost>(this.url, post, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
          new Error(
            'BlogPostService.createPost(): error creating blog post ' + err
          )
        );
      })
    );
  }

  updatePost(id: number, post: BlogPost): Observable<BlogPost> {
    return this.http.put<BlogPost>(`${this.url}/${id}`, post, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
          new Error('BlogPostService.updatePost(): error updating blog post: ' + err)
        );
      })
    );
  }

}
