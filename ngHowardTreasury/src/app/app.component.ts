import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  animations: [
    trigger('routeAnimations', [
      transition('* <=> *', [
        style({ opacity: 0 }),
        animate('0.5s', style({ opacity: 1 })),
      ]),
    ]),
  ]
})
export class AppComponent {
  title = 'ngHowardTreasury';
  sidenav: any;

  onMenuClick() {
    console.log('Menu clicked');
    this.sidenav.toggle();
  }

}
