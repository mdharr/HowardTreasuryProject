import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-image-float',
  templateUrl: './image-float.component.html',
  styleUrls: ['./image-float.component.css']
})
export class ImageFloatComponent {
  @Input() marginBottom: string = '';
  imagePath: string = '';

  imagePaths = [
    "./assets/graphics/conan-min.png",
    "./assets/graphics/mark-schultz-elephant.webp",
    "./assets/graphics/mark-schultz-rogues.webp",
    "./assets/graphics/mark-schultz-phoenix.webp"
  ];

  ngOnInit() {
    this.imagePath = this.selectRandomImage(this.imagePaths);
  }

  selectRandomImage(arr: string[]): string {
    const randomIdx = Math.floor(Math.random() * arr.length);
    return arr[randomIdx];
  }
}
