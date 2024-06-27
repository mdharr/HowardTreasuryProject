import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, catchError, take, throwError } from 'rxjs';

interface ApiResponse {
  products: any[];
  total: number;
  skip: number;
  limit: number;
}

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  page: number = 1;
  itemsPerPage: number = 4;
  skip: number = (this.page - 1) * this.itemsPerPage;

  private allProductsUrl = 'https://dummyjson.com/products';
  private paginatedProductsUrl = `https://dummyjson.com/products?limit=${this.itemsPerPage}&skip=${this.skip}`;

  http = inject(HttpClient);

  getAllProducts(): Observable<ApiResponse> {
    return this.http.get<ApiResponse>(this.allProductsUrl).pipe(
      take(1),
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('ProductService.getAllProducts(): error retrieving list of products ' + err)
        );
      })
    )
  }

  getPaginatedProducts(): Observable<ApiResponse> {
    return this.http.get<ApiResponse>(this.paginatedProductsUrl).pipe(
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
