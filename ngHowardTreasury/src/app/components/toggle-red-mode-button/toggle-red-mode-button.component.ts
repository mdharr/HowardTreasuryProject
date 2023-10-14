import { Component } from '@angular/core';

@Component({
  selector: 'app-toggle-red-mode-button',
  templateUrl: './toggle-red-mode-button.component.html',
  styleUrls: ['./toggle-red-mode-button.component.css']
})
export class ToggleRedModeButtonComponent {


  toggleRedTheme(): void {
    document.body.classList.toggle('red-theme');
  }
}
