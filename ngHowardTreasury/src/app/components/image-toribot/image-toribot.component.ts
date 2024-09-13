import { AfterViewInit, Component, ElementRef, Input, OnChanges, OnInit, Renderer2, SimpleChanges } from '@angular/core';

@Component({
  selector: 'app-image-toribot',
  templateUrl: './image-toribot.component.html',
  styleUrls: ['./image-toribot.component.css']
})
export class ImageToribotComponent implements AfterViewInit, OnChanges {
  @Input() imageUrl: string = './assets/graphics/mark-schultz-rogues.webp';

  constructor(private el: ElementRef) {}

  ngAfterViewInit() {
    this.adjustImageSize();
  }

  ngOnChanges(changes: SimpleChanges) {
    if (changes['imageUrl']) {
      setTimeout(() => this.adjustImageSize(), 0);
    }
  }

  private adjustImageSize() {
    const img = this.el.nativeElement.querySelector('.toribot-image') as HTMLImageElement;
    if (img.complete) {
      this.setImageSize(img);
    } else {
      img.onload = () => this.setImageSize(img);
    }
  }

  private setImageSize(img: HTMLImageElement) {
    const wrap = this.el.nativeElement.querySelector('.wrap') as HTMLElement;
    const aspectRatio = img.naturalWidth / img.naturalHeight;
    const wrapWidth = wrap.offsetWidth;
    const wrapHeight = wrap.offsetHeight;

    if (aspectRatio > wrapWidth / wrapHeight) {
      // Image is wider than the wrap
      img.style.height = '100%';
      img.style.width = 'auto';
    } else {
      // Image is taller than the wrap
      img.style.width = '100%';
      img.style.height = 'auto';
    }
  }
}
