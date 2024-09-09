import { AfterViewInit, ChangeDetectorRef, Component, ElementRef, Input, ViewChild } from '@angular/core';
import { Collection } from 'src/app/models/collection';

@Component({
  selector: 'app-book-cover',
  templateUrl: './book-cover.component.html',
  styleUrls: ['./book-cover.component.css']
})
export class BookCoverComponent implements AfterViewInit {
  @ViewChild('overlayCanvas', { static: true }) overlayCanvas!: ElementRef<HTMLCanvasElement>;
  @ViewChild('coverImage', { static: true }) coverImage!: ElementRef<HTMLImageElement>;

  collectionsByRecommended: Collection[] = [];
  isHovered: boolean = false;
  coverImageUrl: string = 'https://howardtreasury.s3.amazonaws.com/assets/siteassets/the-best-of-robert-e-howard-volume-1-crimson-shadows-thumbnail.png';
  overlayImageUrl: string = 'https://howardtreasury.s3.amazonaws.com/assets/siteassets/illustrations/BestOfVol1/cover.webp';

  private ctx!: CanvasRenderingContext2D;
  private overlayImage: HTMLImageElement = new Image();
  private pixelCoords: [number, number][] = [];
  private animationFrameId: number | null = null;
  private pixelSize: number = 10; // Size of each "pixel" square

  constructor(private cdr: ChangeDetectorRef) {}

  ngAfterViewInit() {
    this.ctx = this.overlayCanvas.nativeElement.getContext('2d')!;
    this.overlayImage.src = this.overlayImageUrl;
    this.overlayImage.onload = () => {
      this.initializePixelCoords();
      this.cdr.detectChanges();
    };
    this.resizeCanvas();
  }

  onImageLoad() {
    this.resizeCanvas();
  }

  private resizeCanvas() {
    const canvas = this.overlayCanvas.nativeElement;
    canvas.width = 200;
    canvas.height = 300;
    this.initializePixelCoords();
  }

  private initializePixelCoords() {
    const width = this.overlayCanvas.nativeElement.width;
    const height = this.overlayCanvas.nativeElement.height;

    this.pixelCoords = [];
    for (let y = 0; y < height; y += this.pixelSize) {
      for (let x = 0; x < width; x += this.pixelSize) {
        this.pixelCoords.push([x, y]);
      }
    }
    this.shuffleArray(this.pixelCoords);
  }

  private shuffleArray(array: any[]) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
  }

  onMouseEnter() {
    this.isHovered = true;
    this.startOverlayAnimation();
  }

  onMouseLeave() {
    this.isHovered = false;
    this.stopOverlayAnimation();
    this.ctx.clearRect(0, 0, this.overlayCanvas.nativeElement.width, this.overlayCanvas.nativeElement.height);
  }

  private startOverlayAnimation() {
    let index = 0;
    const pixelsPerFrame = 20; // Adjust this value to control the speed

    const animatePixels = () => {
      if (index < this.pixelCoords.length && this.isHovered) {
        for (let i = 0; i < pixelsPerFrame && index < this.pixelCoords.length; i++) {
          const [x, y] = this.pixelCoords[index];
          const sourceX = Math.floor(x * (this.overlayImage.width / this.overlayCanvas.nativeElement.width));
          const sourceY = Math.floor(y * (this.overlayImage.height / this.overlayCanvas.nativeElement.height));
          this.ctx.drawImage(
            this.overlayImage,
            sourceX, sourceY,
            this.pixelSize * (this.overlayImage.width / this.overlayCanvas.nativeElement.width),
            this.pixelSize * (this.overlayImage.height / this.overlayCanvas.nativeElement.height),
            x, y,
            this.pixelSize, this.pixelSize
          );
          index++;
        }
        this.animationFrameId = requestAnimationFrame(animatePixels);
      }
    };
    animatePixels();
  }

  private stopOverlayAnimation() {
    if (this.animationFrameId !== null) {
      cancelAnimationFrame(this.animationFrameId);
      this.animationFrameId = null;
    }
  }
}
