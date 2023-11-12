import { Injectable, Renderer2, RendererFactory2 } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ImageZoomService {

  private renderer: Renderer2;

  constructor(rendererFactory: RendererFactory2) {
    this.renderer = rendererFactory.createRenderer(null, null);
  }

  initializeImageZoom(parentElement: HTMLElement) {
    this.renderer.listen(parentElement, 'mouseover', (event) => {
      const target = event.target as HTMLElement;
      if (target.tagName.toLowerCase() === 'img') {
        this.zoomIn(target as HTMLImageElement);
      }
    });

    this.renderer.listen(parentElement, 'mouseout', (event) => {
      const target = event.target as HTMLElement;
      if (target.tagName.toLowerCase() === 'img') {
        this.zoomOut(target as HTMLImageElement);
      }
    });
  }

  private zoomIn(image: HTMLImageElement) {
    // Zoom in logic
    this.renderer.setStyle(image, 'transform', 'scale(1.1)');
    this.renderer.setStyle(image, 'transition', 'transform 0.5s ease');
  }

  private zoomOut(image: HTMLImageElement) {
    // Zoom out logic
    this.renderer.setStyle(image, 'transform', '');
  }
}
