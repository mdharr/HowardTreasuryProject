import { Directive, ElementRef, EventEmitter, OnInit, Output } from '@angular/core';

@Directive({
  selector: '[appImageLoad]'
})
export class ImageLoadDirective implements OnInit {
  @Output() imageLoaded = new EventEmitter<boolean>();

  constructor(private el: ElementRef) {}

  ngOnInit() {
    const img = this.el.nativeElement;

    // Handle successful load
    img.addEventListener('load', () => {
      this.imageLoaded.emit(true);
    });

    // Handle load failure
    img.addEventListener('error', () => {
      this.imageLoaded.emit(false);
    });
  }
}
