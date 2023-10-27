import { Component } from '@angular/core';

@Component({
  selector: 'app-toggle-red-mode-button',
  templateUrl: './toggle-red-mode-button.component.html',
  styleUrls: ['./toggle-red-mode-button.component.css']
})
export class ToggleRedModeButtonComponent {

  isRedTheme!: boolean;

  ngOnInit() {
    this.isRedTheme = localStorage.getItem('theme') === 'red-theme';
    this.toggleTheme(this.isRedTheme);
  }

  toggleRedTheme() {
    this.isRedTheme = !this.isRedTheme;
    this.toggleTheme(this.isRedTheme);

    localStorage.setItem('theme', this.isRedTheme ? 'red-theme' : 'default-theme');
  }

  private toggleTheme(isRedTheme: boolean) {
    if (isRedTheme) {
      document.body.classList.add('red-theme');
    } else {
      document.body.classList.remove('red-theme');
    }
  }

  // toggleRedTheme(): void {
  //   document.body.classList.toggle('red-theme');
  // }
}
