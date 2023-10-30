import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-image-tooltip',
  templateUrl: './image-tooltip.component.html',
  styleUrls: ['./image-tooltip.component.css']
})
export class ImageTooltipComponent {
  @Input() imageSrc: string = '';
  zoomState: string = 'initial';
}
