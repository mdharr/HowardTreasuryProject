import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, catchError, filter, map, take, throwError } from 'rxjs';

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
      map(response => {
        const filteredProducts = response.products.filter(product => product.title.charAt(0).toLowerCase() === 'c');
        return { ...response, products: filteredProducts };
      }),
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('ProductService.getAllProducts(): error retrieving list of products ' + err)
        );
      })
    )
  }

  // getAllProducts(): Observable<ApiResponse> {
  //   return this.http.get<ApiResponse>(this.allProductsUrl).pipe(
  //     catchError((err: any) => {
  //       console.error(err);
  //       return throwError(
  //         () =>
  //           new Error('ProductService.getAllProducts(): error retrieving list of products ' + err)
  //       );
  //     })
  //   )
  // }

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
