import { Component } from '@angular/core';
import {
  trigger,
  state,
  style,
  animate,
  transition,
} from '@angular/animations';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css'],
  animations: [
    trigger('expandMenu', [
      state(
        'collapsed',
        style({
          height: '0',
          overflow: 'hidden',
          opacity: '0',
        })
      ),
      state(
        'expanded',
        style({
          height: '*',
          overflow: 'visible',
          opacity: '1',
        })
      ),
      transition('collapsed <=> expanded', [animate('300ms cubic-bezier(0.68, -0.55, 0.27, 1.55)')]),
    ]),
  ],
})
export class NavbarComponent {
  menuState: 'collapsed' | 'expanded' = 'collapsed';

  toggleMenu() {
    this.menuState = this.menuState === 'collapsed' ? 'expanded' : 'collapsed';
  }
}
