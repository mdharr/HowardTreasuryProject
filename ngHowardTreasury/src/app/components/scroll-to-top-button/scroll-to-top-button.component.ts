import { Component, HostListener } from '@angular/core';

@Component({
  selector: 'app-scroll-to-top-button',
  templateUrl: './scroll-to-top-button.component.html',
  styleUrls: ['./scroll-to-top-button.component.css']
})
export class ScrollToTopButtonComponent {
  @HostListener('window:scroll', [])
  onWindowScroll() {
    this.toggleButtonVisibility();
  }

  scrollToTop() {
    // Add a small delay (e.g., 100 milliseconds) before scrolling
    setTimeout(() => {
      window.scrollTo({ top: 0, behavior: 'auto' });
    }, 100);
  }

  toggleButtonVisibility() {
    const button = document.querySelector('.scroll-to-top-button') as HTMLElement;
    if (button) {
      button.style.display = window.scrollY > 300 ? 'flex' : 'none';
      button.style.alignItems = window.scrollY > 300 ? 'center' : 'none';
    }
  }

}
