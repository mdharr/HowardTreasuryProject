import { ImageZoomService } from './../../services/image-zoom.service';
import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component, inject } from '@angular/core';

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

  imageZoomService = inject(ImageZoomService);

  onMouseEnter() {
    this.zoomState = 'zoomed';
    this.imageZoomService.setZoomState(true);
  }

  onMouseLeave() {
    this.zoomState = 'initial';
    this.imageZoomService.setZoomState(false);
  }
}
