import { DOCUMENT } from '@angular/common';
import { Component, EventEmitter, HostListener, Inject, Input, Output, Renderer2 } from '@angular/core';

@Component({
  selector: 'app-fullscreen-image',
  templateUrl: './fullscreen-image.component.html',
  styleUrls: ['./fullscreen-image.component.css']
})
export class FullscreenImageComponent {
  @Input() imageUrl!: string;
  @Output() closed = new EventEmitter<void>();
  isVisible: boolean = false;

  constructor(@Inject(DOCUMENT) private document: Document, private renderer: Renderer2) {}

  @HostListener('document:keydown.escape', ['$event'])
  onEscapePress(event: KeyboardEvent) {
    this.close();
  }

  open() {
    this.isVisible = true;
    this.renderer.addClass(this.document.body, 'disable-scrolling');
  }

  close() {
    this.isVisible = false;
    this.renderer.removeClass(this.document.body, 'disable-scrolling');
    this.closed.emit();
  }

}
