import { AfterViewInit, Component, ElementRef, HostListener, inject, Input, OnDestroy, OnInit, QueryList, Renderer2, ViewChild, ViewChildren } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Collection } from 'src/app/models/collection';
import { CollectionService } from 'src/app/services/collection.service';

@Component({
  selector: 'app-page-flip',
  templateUrl: './page-flip.component.html',
  styleUrls: ['./page-flip.component.css']
})
export class PageFlipComponent implements OnInit, OnDestroy {

  overlayImageUrl: string = '';
  recommendedCollections: Collection[] = [];

  sampleImageUrls: string[] = [
    'https://www.jimzub.com/wp-content/uploads/2024/09/PhoenixOnTheSwordTitlePage-WeirdTales-1337x1536.jpg',
    'https://www.jimzub.com/wp-content/uploads/2024/09/ScarletCitadelTitlePage-WeirdTales.jpg',
    'https://www.jimzub.com/wp-content/uploads/2024/09/TowerOfTheElephantTitlePage-WeirdTales.jpg',
    'https://www.jimzub.com/wp-content/uploads/2024/09/PhoenixOnTheSwordTitlePage-WeirdTales-1337x1536.jpg',
    'https://www.jimzub.com/wp-content/uploads/2024/09/BlackColossusTitlePage-WeirdTales-1307x1536.jpg',
    'https://www.jimzub.com/wp-content/uploads/2024/09/SlitheringShadow-WeirdTales-1322x1536.jpg',
  ];

  sampleImage: string = '';
  hoveredBookId: number | null = null;

  @ViewChildren('bookContainer') bookContainers!: QueryList<ElementRef>;
  @ViewChildren('book') books!: QueryList<ElementRef>;
  @ViewChildren('overlay') overlays!: QueryList<ElementRef>;

  @ViewChild('coverCanvas') canvasRef!: ElementRef<HTMLCanvasElement>;
  @ViewChild('backgroundImage') imageRef!: ElementRef<HTMLImageElement>;
  @ViewChild('overlayVideo') videoRef!: ElementRef<HTMLVideoElement>;

  // @ViewChild('backgroundOverlay') backgroundOverlayRef!: ElementRef;
  private backgroundOverlay: HTMLElement | null = null;



  private isAnimating: boolean = false;

  activeBook: {
    container: HTMLElement,
    book: HTMLElement,
    overlay: HTMLElement,
    collectionId: number,
    videoEffect?: VideoOverlayEffect
  } | null = null;

  private collectionSub: Subscription | undefined;

  private collectionService = inject(CollectionService);

  constructor(private renderer: Renderer2, private router: Router) {}

  ngOnInit() {
    this.collectionSub = this.collectionService.indexAll().subscribe({
      next: (data: Collection[]) => {
        this.recommendedCollections = data;
      },
      error: (err) => {
        console.error(err);
      }
    });
    this.createBackgroundOverlay();
  }

  ngOnDestroy() {
    if (this.collectionSub) {
      this.collectionSub.unsubscribe();
    }
  }

  private createBackgroundOverlay() {
    this.backgroundOverlay = this.renderer.createElement('div');
    this.renderer.addClass(this.backgroundOverlay, 'background-overlay');
    this.renderer.appendChild(document.body, this.backgroundOverlay);
  }

  private removeBackgroundOverlay() {
    if (this.backgroundOverlay) {
      this.renderer.removeChild(document.body, this.backgroundOverlay);
      this.backgroundOverlay = null;
    }
  }

  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent) {
    if (this.activeBook && !this.activeBook.container.contains(event.target as Node)) {
      this.resetActiveBook();
    }
  }

  getRandomIdxOfArr(arr: string[]) {
    const random = Math.floor(Math.random() * arr.length-1);
    return arr[random];
  }

  startAnimation(bookContainer: HTMLElement, book: HTMLElement, overlay: HTMLElement, collectionId: number, event: MouseEvent) {
    event.stopPropagation();
    if (this.isAnimating) return;

    this.sampleImage = this.getRandomIdxOfArr(this.sampleImageUrls);

    if (this.activeBook) {
      if (this.activeBook.container === bookContainer) {
        this.completeAnimation();
      } else {
        this.resetActiveBook();
      }
      return;
    }

    this.isAnimating = true;

    const rect = bookContainer.getBoundingClientRect();
    const scrollX = window.scrollX;
    const scrollY = window.scrollY;

    const bookX = rect.left + scrollX - 100;
    const bookY = rect.top + scrollY;

    const viewportCenterX = window.innerWidth / 2;
    const viewportCenterY = window.innerHeight / 2;

    const translateX = viewportCenterX - (bookX + rect.width / 2);
    const translateY = viewportCenterY - (bookY + rect.height / 2);

    this.setActiveBookZIndex(bookContainer);
    this.renderer.addClass(book, 'pickup');

    setTimeout(() => {
      this.renderer.addClass(bookContainer, 'move-to-center');
      this.renderer.setStyle(bookContainer, 'transform', `translate(${translateX}px, ${translateY}px) scale(1.5)`);
      if (this.backgroundOverlay) {
        this.renderer.addClass(this.backgroundOverlay, 'active');
      }

      setTimeout(() => {
        this.renderer.addClass(book.querySelector('.cover'), 'open-cover');
        this.activeBook = { container: bookContainer, book, overlay, collectionId };
        this.isAnimating = false;

        // Initialize video overlay effect after the book is opened
        setTimeout(() => {
          const video = book.querySelector('.cover-back video') as HTMLVideoElement;
          if (video) {
            this.activeBook!.videoEffect = new VideoOverlayEffect(video);
          }
        }, 300);
      }, 300);
    }, 300);
  }

  private completeAnimation() {
    if (!this.activeBook) return;
    const { container: bookContainer, book, overlay, collectionId } = this.activeBook;

    this.isAnimating = true;
    this.renderer.addClass(bookContainer, 'grow');
    this.renderer.setStyle(overlay, 'opacity', '1');

    setTimeout(() => {
      this.router.navigate(['/collections', collectionId]);
      this.isAnimating = false;
      this.resetActiveBook();
    }, 300);
  }

  private resetActiveBook() {
    if (!this.activeBook) return;
    const { container: bookContainer, book, overlay, videoEffect } = this.activeBook;

    this.isAnimating = true;
    this.renderer.removeClass(book.querySelector('.cover'), 'open-cover');
    if (this.backgroundOverlay) {
      this.renderer.removeClass(this.backgroundOverlay, 'active');
    }

    if (videoEffect) {
      videoEffect.destroy();
    }

    setTimeout(() => {
      this.renderer.removeClass(bookContainer, 'move-to-center');
      this.renderer.removeClass(book, 'pickup');
      this.renderer.removeStyle(bookContainer, 'transform');
      this.renderer.setStyle(bookContainer, 'transition', 'all 0.3s ease-out, z-index 0s 0.3s');

      setTimeout(() => {
        this.resetBookZIndex(bookContainer);
        this.isAnimating = false;
        this.activeBook = null;
        this.renderer.removeStyle(bookContainer, 'transition');
      }, 300);
    }, 300);

    this.sampleImage = '';
  }

  private resetBookStyles(bookContainer: HTMLElement, book: HTMLElement, overlay: HTMLElement) {
    this.renderer.removeClass(bookContainer, 'move-to-center');
    this.renderer.removeClass(bookContainer, 'grow');
    this.renderer.removeClass(book, 'pickup');
    this.renderer.removeClass(book.querySelector('.cover'), 'open-cover');
    this.renderer.removeStyle(bookContainer, 'transform');
    this.renderer.setStyle(overlay, 'opacity', '0');

    // Delay resetting z-index
    setTimeout(() => {
      this.resetBookZIndex(bookContainer);
    }, 300);
  }

  private setActiveBookZIndex(activeBookContainer: HTMLElement) {
    this.renderer.setStyle(activeBookContainer, 'z-index', '1001');
    this.bookContainers.forEach(container => {
      if (container.nativeElement !== activeBookContainer) {
        this.renderer.setStyle(container.nativeElement, 'z-index', '1');
      }
    });
  }

  private resetBookZIndex(bookContainer: HTMLElement) {
    this.renderer.setStyle(bookContainer, 'z-index', 'auto');
    this.bookContainers.forEach(container => {
      if (container.nativeElement !== bookContainer) {
        this.renderer.setStyle(container.nativeElement, 'z-index', 'auto');
      }
    });
  }

  onBookHover(bookContainer: HTMLElement, collectionId: number) {
    if (this.isAnimating || !this.activeBook || this.activeBook.collectionId !== collectionId) return;

    this.hoveredBookId = collectionId;
    const coverBackImage = bookContainer.querySelector('.cover-back img') as HTMLElement;
    if (coverBackImage) {
      this.renderer.addClass(coverBackImage, 'reveal');
    }
  }

  onBookLeave(bookContainer: HTMLElement) {
    if (this.isAnimating || !this.activeBook) return;

    this.hoveredBookId = null;
    const coverBackImage = bookContainer.querySelector('.cover-back img') as HTMLElement;
    if (coverBackImage) {
      this.renderer.removeClass(coverBackImage, 'reveal');
    }
  }
}

class VideoOverlayEffect {
  constructor(private video: HTMLVideoElement) {
    this.video.play();
  }

  destroy() {
    this.video.pause();
    this.video.currentTime = 0;
  }
}
