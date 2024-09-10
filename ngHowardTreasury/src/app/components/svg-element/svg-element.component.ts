import { Component, AfterViewInit, Input } from '@angular/core';

@Component({
  selector: 'app-svg-element',
  templateUrl: './svg-element.component.html',
  styleUrls: ['./svg-element.component.css']
})
export class SvgElementComponent {

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
