import { DOCUMENT } from '@angular/common';
import { Component, ElementRef, HostListener, Inject, inject, Input, Renderer2 } from '@angular/core';

@Component({
  selector: 'app-image-gallery',
  templateUrl: './image-gallery.component.html',
  styleUrls: ['./image-gallery.component.css']
})
export class ImageGalleryComponent {

  @Input() images: string[] = [];
  // kenKellyImages: string[] = [
  //   "https://reh.world/wp-content/gallery/ken-kelly/Escape-From-Khan.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Fantasy-Painting-Original-Art-1978-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Ylana-of-Callisto.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/The-Mighty-King-1991.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-by-Ken-Kelly2-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Red-Nails-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/The-Hour-of-the-Dragon-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-The-Clan-of-the-Cats-Paperback-Cover-Original-Art.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15150056-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15202413.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15173625-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15314953-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15512706-1-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15471234-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15454247-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15244952-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15233407-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/img20201108_15221112-scaled.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Fantasy-art-Fantasy-ero-%D0%A0%D0%B5%D1%82%D1%80%D0%BE-%D1%84%D1%8D%D0%BD%D1%82%D0%B5%D0%B7%D0%B8-7223991.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/%D0%9A%D0%B8%D0%BD%D0%B3-%D0%9A%D0%BE%D0%BD%D0%B3-%D0%A4%D0%B8%D0%BB%D1%8C%D0%BC%D1%8B-ken-kelly-artist-7230019.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/two-against-tyre.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/The-Daughter-of-Erlik-Khan-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Solomon-Kane-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Skull-Face-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-with-a-stone-axe-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-and-the-Queen-of-the-Black-Coast-Gurps-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Black-Vulmeas-vengeance-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Conan-Painting-Demon-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-the-Formidable-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Cormac-Mac-Art-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Sea-Venom.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Black-Canaan-Cover-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Monstrous.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Entrapped-Conan.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Conan-vs.-Cyclops-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Conan-and-the-Emerald-Lotus-Cover-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Trails-in-Darkness.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan_snake.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/1_Conan-with-a-stone-axe-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/21551856573_1607e18053_o-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/MDJ_KenKelly_4-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/marchers.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/comment_z2PKohtUiLHvyyOFTvhf5TZx5VeNRzds-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Almuric.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/14_REH_thelastride_kenkelly.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Ken-Kelly-Looming-Menace.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/ken_kelly_revenge_of_the_viking.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/10_REH_thewhitewolf_kenkelly.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/05_REH_lostvalleyofiskander_kenkelly.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/red-blades-from-black-cathay-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/two-against-tyre-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-by-Ken-Kelly.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/KEN-KELLY-American-b.1946.-Eons-of-the-Night-1995.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-with-an-axe-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/CONAN-THE-CONQUEROR.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-The-Bold-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Warriors-of-the-Way.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-holding-sword-Forbedret.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/EDUGefQXYAE0MW-.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-the-Savage.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Pit-fighter-Edit.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-get-back.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Conan-running-with-girl2.jpg",
  //   "https://reh.world/wp-content/gallery/ken-kelly/Giant-octopus.jpg"
  // ];

  // lightbox properties
  centerOffset: number = 0;
  showLightbox = false;
  selectedImage: any;
  currentIndex = 0;
  selectedThumbnailIndex = 0;

  // dependency injection
  renderer = inject(Renderer2);
  elementRef = inject(ElementRef);

  constructor(@Inject(DOCUMENT) private document: Document) {}

  openLightbox(index: number, event: MouseEvent) {
    event.stopPropagation();
    this.showLightbox = true;
    // this.selectedImage = this.kenKellyImages[index];
    this.selectedImage = this.images[index];
    this.selectedThumbnailIndex = index;
    this.currentIndex = index;
    if (this.showLightbox) {
      this.renderer.addClass(this.document.body, 'disable-scrolling');
    }

    setTimeout(() => {
      this.selectImage(this.currentIndex);
    }, 0);
  }


  async selectImage(index: number, isInitialLoad: boolean = false) {
    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    // Immediately set opacity to 1 for initial load
    if (isInitialLoad) {
      currentImageElement.style.opacity = '1';
    } else if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    // Wait for the new image size calculation
    // const newImageSize = await this.calculateNewImageSize(this.kenKellyImages[index]);
    const newImageSize = await this.calculateNewImageSize(this.images[index]);

    setTimeout(() => {
      // Update the selected image
      this.currentIndex = index;
      // this.selectedImage = this.kenKellyImages[index];
      this.selectedImage = this.images[index];
      this.selectedThumbnailIndex = index;
      this.updateThumbnailPosition();

      // Apply the new size to the container
      const container = this.document.querySelector('.lightbox-image-container') as HTMLElement;
      if (container) {
        if (isInitialLoad) {
          // For initial load, remove the transition class after setting the size
          container.style.width = `${newImageSize.width}px`;
          container.style.height = `${newImageSize.height}px`;
          container.classList.remove('no-transition');
        } else {
          // For subsequent loads, ensure the transition class is not present
          container.style.width = `${newImageSize.width}px`;
          container.style.height = `${newImageSize.height}px`;
        }
      }

      // Fade in the new image after the container resizing
      setTimeout(() => {
        if (currentImageElement) {
          currentImageElement.style.opacity = '1';
        }
      }, 500);
    }, 500);
  }



  private calculateNewImageSize(imageUrl: string): Promise<{ width: number, height: number }> {
    return new Promise((resolve, reject) => {
      const img = new Image();

      img.onload = () => {
        const maxWidth = window.innerWidth * 0.9; // 90% of the window width
        const maxHeight = window.innerHeight * 0.7; // 80% of the window height

        // Original dimensions
        const originalWidth = img.naturalWidth;
        const originalHeight = img.naturalHeight;

        // Check if the image needs resizing
        if (originalWidth <= maxWidth && originalHeight <= maxHeight) {
          resolve({ width: originalWidth, height: originalHeight });
          return;
        }

        // Calculate aspect ratio
        const aspectRatio = originalWidth / originalHeight;

        // Calculate new dimensions while maintaining aspect ratio
        let newWidth = maxWidth;
        let newHeight = newWidth / aspectRatio;

        if (newHeight > maxHeight) {
          newHeight = maxHeight;
          newWidth = newHeight * aspectRatio;
        }

        resolve({ width: newWidth, height: newHeight });
      };

      img.onerror = () => {
        reject('Could not load image');
      };

      img.src = imageUrl; // Set the source of the image
    });
  }

  getThumbnailTransform(): string {
    // if (!this.kenKellyImages.length) return '';
    if (!this.images.length) return '';

    const thumbnailWidth = 50; // Width of each thumbnail
    const gapBetweenThumbnails = 10; // Adjust if there's a gap between thumbnails
    const effectiveThumbnailWidth = thumbnailWidth + gapBetweenThumbnails; // Total space taken by each thumbnail including gap

    // Calculate the position of the center of the selected thumbnail
    const selectedThumbnailCenter = this.selectedThumbnailIndex * effectiveThumbnailWidth + thumbnailWidth / 2;

    // Calculate the center of the thumbnails container
    const containerCenter = window.innerWidth / 2;

    // Calculate the transform value
    const transformValue = containerCenter - selectedThumbnailCenter;

    return `translateX(${transformValue}px)`;
  }


  private updateThumbnailPosition() {
    const thumbnailWidth = 50; // Adjust as needed
    // const thumbnailsCount = this.kenKellyImages.length;
    const thumbnailsCount = this.images.length;
    const containerWidth = thumbnailsCount * thumbnailWidth;
    const transform = containerWidth / 2 - this.selectedThumbnailIndex * thumbnailWidth;

    const thumbnailsContainer = this.elementRef.nativeElement.querySelector('.thumbnails-container') as HTMLElement;
    if (thumbnailsContainer) {
      thumbnailsContainer.style.transform = `translateX(${transform}px)`;
    }
  }

  closeLightbox() {
    this.showLightbox = false;
    this.renderer.removeClass(this.document.body, 'disable-scrolling');
  }

  nextImage() {
    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    setTimeout(() => {
      // this.currentIndex = (this.currentIndex + 1) % this.kenKellyImages.length;
      this.currentIndex = (this.currentIndex + 1) % this.images.length;
      this.selectImage(this.currentIndex);
    }, 0); // Match the duration of the fade-out transition
  }

  prevImage() {
    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    setTimeout(() => {
      // this.currentIndex = (this.currentIndex - 1 + this.kenKellyImages.length) % this.kenKellyImages.length;
      this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length;
      this.selectImage(this.currentIndex);
    }, 0); // Match the duration of the fade-out transition
  }


  downloadImage(image: any) {
    // Replace 'image.blobUrl' with the actual property that stores the image URL.
    const downloadLink = document.createElement('a');
    downloadLink.href = image.textUrl;
    downloadLink.download = 'image.jpg'; // Set the desired file name.
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
  }

  onLightboxImageClick(event: MouseEvent) {
    const clickX = event.clientX;
    const lightboxImageElement = event.target as HTMLElement;
    const lightboxImageRect = lightboxImageElement.getBoundingClientRect();
    const lightboxImageWidth = lightboxImageRect.width;

    const currentImageElement = this.document.querySelector('.lightbox-image') as HTMLElement;
    if (currentImageElement) {
      currentImageElement.style.opacity = '0';
    }

    setTimeout(() => {
      if (clickX < lightboxImageRect.left + lightboxImageWidth / 2) {
        // Clicked on the left half
        this.prevImage();
      } else {
        // Clicked on the right half
        this.nextImage();
      }
    }, 0); // Match the duration of the fade-out transition
  }

  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent) {
    if (this.showLightbox) {
      const lightboxContent = this.elementRef.nativeElement.querySelector('.lightbox-content');
      const lightboxImages = this.elementRef.nativeElement.querySelectorAll('.lightbox-image');

      // Check if the clicked element is outside the lightbox content
      if (lightboxContent && !lightboxContent.contains(event.target)) {
        // Check if the clicked element is any of the lightbox images
        let clickedOnLightboxImage = false;
        lightboxImages.forEach((image: HTMLElement) => {
          if (image.contains(event.target as Node)) {
            clickedOnLightboxImage = true;
            return;
          }
        });

        if (!clickedOnLightboxImage) {
          this.closeLightbox();
        }
      }
    }
  }

  getLightboxBackgroundStyle(): any {
    if (this.selectedImage) {
      const backgroundImage = `url(${this.selectedImage})`;
      const filterProperties = 'blur(20px) brightness(50%)';
      return {
        'background-image': backgroundImage,
        'background-size': 'cover', // Set the background size to cover
        filter: filterProperties,
        position: 'fixed',
        top: '-50px',
        left: '-50px',
        width: '120%',
        height: '120%',
        zIndex: '1',
        boxShadow: 'inset 0 0 10em 15em rgba(0, 0, 0, 0.5)'
      };
    } else {
      return {};
    }
  }

  getLightboxThumbnailStyle(index: number): any {
    if (this.selectedImage && index === this.selectedThumbnailIndex) {
      const border = '2px solid var(--red_color)';
      return {
        border: border,
        transition: 'border 0.2s'
      };
    } else {
      return {};
    }
  }
}
