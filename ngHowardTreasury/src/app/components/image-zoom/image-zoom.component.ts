import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';

@Component({
  selector: 'app-image-zoom',
  templateUrl: './image-zoom.component.html',
  styleUrls: ['./image-zoom.component.css'],
  animations: [
    trigger('zoomAnimation', [
      state('initial', style({ transform: 'scale(1)' })),
      state('zoomed', style({ transform: 'scale(1.1)' })),
      transition('initial => zoomed', animate('0.2s')),
      transition('zoomed => initial', animate('0.2s'))
    ])
  ]
})
export class ImageZoomComponent {
  zoomState = 'initial';

  onMouseEnter() {
    this.zoomState = 'zoomed';
  }

  onMouseLeave() {
    this.zoomState = 'initial';
  }
}
