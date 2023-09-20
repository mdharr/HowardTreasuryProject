import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'ngHowardTreasury';
  sidenav: any;

  onMenuClick() {
    console.log('Menu clicked');
    this.sidenav.toggle();
  }

}
