import { AfterViewInit, Component, ElementRef, HostListener, Input, NgZone, OnInit, ViewChild } from '@angular/core';

@Component({
  selector: 'app-image-zoom',
  templateUrl: './image-zoom.component.html',
  styleUrls: ['./image-zoom.component.css']
})
export class ImageZoomComponent implements AfterViewInit {
  @Input() imageSrc!: string;
  @Input() imageAlt: string = '';
  @Input() zoomLevel: number = 2;
  @Input() lensWidth: number = 150;
  @Input() lensHeight: number = 150;

  @ViewChild('image') imageElement!: ElementRef<HTMLImageElement>;

  isZoomed: boolean = false;
  lensTop: number = 0;
  lensLeft: number = 0;
  translateX: number = 0;
  translateY: number = 0;
  imageWidth: number = 0;
  imageHeight: number = 0;

  ngAfterViewInit() {
    this.updateImageSize();
  }

  updateImageSize() {
    this.imageWidth = this.imageElement.nativeElement.clientWidth;
    this.imageHeight = this.imageElement.nativeElement.clientHeight;
  }

  onMouseMove(event: MouseEvent) {
    if (!this.isZoomed) return;

    const rect = this.imageElement.nativeElement.getBoundingClientRect();
    const mouseX = event.clientX - rect.left;
    const mouseY = event.clientY - rect.top;

    // Position the lens
    this.lensLeft = mouseX - this.lensWidth / 2;
    this.lensTop = mouseY - this.lensHeight / 2;

    // Calculate the position of the zoomed image within the lens
    this.translateX = -(mouseX * this.zoomLevel - this.lensWidth / 2);
    this.translateY = -(mouseY * this.zoomLevel - this.lensHeight / 2);

    // Boundary checks
    this.lensLeft = Math.max(0, Math.min(this.lensLeft, this.imageWidth - this.lensWidth));
    this.lensTop = Math.max(0, Math.min(this.lensTop, this.imageHeight - this.lensHeight));
  }

  onMouseEnter() {
    this.isZoomed = true;
  }

  onMouseLeave() {
    this.isZoomed = false;
  }

  @HostListener('window:resize')
  onResize() {
    this.updateImageSize();
  }
}
