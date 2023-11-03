import { ComponentRef, Directive, ElementRef, HostListener, Input, ViewContainerRef } from '@angular/core';
import { ImageTooltipComponent } from '../components/image-tooltip/image-tooltip.component';

@Directive({
  selector: '[appImageZoom]'
})
export class ImageZoomDirective {
  @Input() imageSrc: string = '';

  private tooltipComponentRef: ComponentRef<ImageTooltipComponent | null> | null = null;

  constructor(private vcr: ViewContainerRef, private el: ElementRef) {}

  @HostListener('mouseenter') onMouseEnter() {
    if (!this.tooltipComponentRef) {
      const factory = this.vcr.createComponent(ImageTooltipComponent);
      this.tooltipComponentRef = factory;

      if (this.tooltipComponentRef && this.tooltipComponentRef.instance) {
        this.tooltipComponentRef.instance.imageSrc = this.imageSrc;

        // Calculate the position based on the hovered image
        const imageRect = this.el.nativeElement.getBoundingClientRect();
        const tooltipElement = this.tooltipComponentRef.location.nativeElement;

        // Set the left position to align with the left side of the image
        tooltipElement.style.left = imageRect.left + 'px';
        console.log('ImageRect left: ' + imageRect.left);
        console.log('tooltip left: ' + tooltipElement.style.left);


        // Set the top position to display directly above the image
        tooltipElement.style.top = imageRect.top - tooltipElement.clientHeight + 'px';
        console.log('ImageRect top: ' + imageRect.top);
        console.log('tooltip top: ' + tooltipElement.style.top);
      }
    }
  }

  @HostListener('mouseleave') onMouseLeave() {
    if (this.tooltipComponentRef) {
      this.tooltipComponentRef.destroy();
      this.tooltipComponentRef = null;
    }
  }
}
