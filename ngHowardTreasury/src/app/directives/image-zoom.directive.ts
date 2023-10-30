import { ComponentRef, Directive, HostListener, Input, ViewContainerRef } from '@angular/core';
import { ImageTooltipComponent } from '../components/image-tooltip/image-tooltip.component';

@Directive({
  selector: '[appImageZoom]'
})
export class ImageZoomDirective {
  @Input() imageSrc: string = '';

  private tooltipComponentRef: ComponentRef<ImageTooltipComponent | null> | null = null;

  constructor(private vcr: ViewContainerRef) {}

  @HostListener('mouseenter') onMouseEnter() {
    if (!this.tooltipComponentRef) {
      const factory = this.vcr.createComponent(ImageTooltipComponent);
      this.tooltipComponentRef = factory;

      if (this.tooltipComponentRef && this.tooltipComponentRef.instance) {
        this.tooltipComponentRef.instance.imageSrc = this.imageSrc;
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
