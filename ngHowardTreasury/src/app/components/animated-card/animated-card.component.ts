import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-animated-card',
  templateUrl: './animated-card.component.html',
  styleUrls: ['./animated-card.component.css']
})
export class AnimatedCardComponent {
  @Input() logoSrc: string = '';
  @Input() frontImageSrc: string = '';
  @Input() bgImageSrc: string = '';
  @Input() objectPosition: string = 'center';
}
