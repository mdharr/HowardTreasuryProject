import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-image-tooltip',
  templateUrl: './image-tooltip.component.html',
  styleUrls: ['./image-tooltip.component.css']
})
export class ImageTooltipComponent {
  @Input() imageSrc: string = '';
  zoomState: string = 'initial';
  tooltipWidth: number = 0;
  tooltipHeight: number = 0;

  ngOnInit() {
    this.loadImageDimensions();
  }

  private loadImageDimensions() {
    const img = new Image();
    img.src = this.imageSrc;
    img.onload = () => {
      this.tooltipWidth = img.width;
      this.tooltipHeight = img.height;
    };
  }
}
