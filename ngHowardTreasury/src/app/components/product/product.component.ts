import { Component, OnDestroy, OnInit, inject } from '@angular/core';
import { Subscription } from 'rxjs';
import { ProductService } from 'src/app/services/product.service';

interface ApiResponse {
  products: any[];
  total: number;
  skip: number;
  limit: number;
}

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit, OnDestroy {

  products: any[] = [];
  paginatedProducts: any[] = [];

  productSub: Subscription | undefined;
  paginatedProductSub: Subscription | undefined;
  productSubsArr: Subscription[] | undefined;

  productService = inject(ProductService);

  ngOnInit(): void {
    this.subscribeToProducts();
    this.subscribeToPaginatedProducts();
  }

  ngOnDestroy(): void {
      if (this.productSubsArr) {
        this.productSubsArr.forEach((sub) => {
          sub.unsubscribe();
        });
      }
      if (this.paginatedProductSub) {
        this.paginatedProductSub.unsubscribe();
      }
  }

  subscribeToProducts() {
    this.productSub = this.productService.getAllProducts().subscribe({
      next: (data: ApiResponse) => {
        this.products = data.products;
        console.log(this.products);
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

  subscribeToPaginatedProducts() {
    this.paginatedProductSub = this.productService.getPaginatedProducts().subscribe({
      next: (data: ApiResponse) => {
        this.paginatedProducts = data.products;
        console.log(this.paginatedProducts);
      },
      error: (err) => {
        console.error(err);
      }
    })
  }
}
