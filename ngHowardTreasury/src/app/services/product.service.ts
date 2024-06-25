import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  private allProductsUrl = environment.baseUrl + 'https://dummyjson.com/products';

  http = inject(HttpClient);

  getAllProducts(): Observable<any[]> {
    return this.http.get<any[]>(this.allProductsUrl).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('ProductService.getAllProducts(): error retrieving list of products ' + err)
        );
      })
    )
  }
}
