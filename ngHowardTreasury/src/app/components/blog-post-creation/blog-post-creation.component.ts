import { Component, inject } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';

@Component({
  selector: 'app-blog-post-creation',
  templateUrl: './blog-post-creation.component.html',
  styleUrls: ['./blog-post-creation.component.css']
})
export class BlogPostCreationComponent {

  editorConfig = {
    base_url: '/tinymce',
    suffix: '.min',
    plugins: 'lists link image table wordcount'
  };

  domSanitizer = inject(DomSanitizer);

}
