import { Injectable, Renderer2, RendererFactory2 } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ImageZoomService {

  private renderer: Renderer2;

  constructor(rendererFactory: RendererFactory2) {
    this.renderer = rendererFactory.createRenderer(null, null);
  }

  addZoomEffect(image: HTMLImageElement) {
    this.renderer.listen(image, 'mouseenter', () => this.zoomIn(image));
    this.renderer.listen(image, 'mouseleave', () => this.zoomOut(image));
  }

  private zoomIn(image: HTMLImageElement) {
    // Implement zoom in logic, e.g., increase size, add shadow, etc.
    this.renderer.setStyle(image, 'transform', 'scale(1.1)');
    this.renderer.setStyle(image, 'transition', 'transform 0.5s ease');
  }

  private zoomOut(image: HTMLImageElement) {
    // Reset zoom on mouse leave
    this.renderer.setStyle(image, 'transform', 'scale(1)');
  }
}
