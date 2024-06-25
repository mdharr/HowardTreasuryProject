import { Component, OnInit, inject } from '@angular/core';
import { Subscription } from 'rxjs';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit {

  products: any[] = [];

  productSub: Subscription | undefined;

  productService = inject(ProductService);

  ngOnInit(): void {
    this.subscribeToProducts();
  }

  subscribeToProducts() {
    this.productSub = this.productService.getAllProducts().subscribe({
      next: (data) => {
        this.products = data;
        console.log(this.products);
      },
      error: (err) => {
        console.error(err);
      }
    })
  }
}
