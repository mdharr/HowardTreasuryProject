import { BlogPostService } from 'src/app/services/blog-post.service';
import { Component, inject } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { NgForm } from '@angular/forms';
import { BlogPost } from 'src/app/models/blog-post';

@Component({
  selector: 'app-blog-post-creation',
  templateUrl: './blog-post-creation.component.html',
  styleUrls: ['./blog-post-creation.component.css']
})
export class BlogPostCreationComponent {

  editorConfig = {
    base_url: '/tinymce',
    suffix: '.min',
    plugins: 'lists link image table wordcount media searchreplace preview importcss fullscreen anchor autoresize'
  };

  post: BlogPost = new BlogPost();

  domSanitizer = inject(DomSanitizer);
  blogPostService = inject(BlogPostService);

  isEditorContentValid(): boolean {
    // Check if the editor content is not empty (you can add more specific checks here)
    return !!(this.post.content && this.post.content.trim().length > 0);
  }

  onSubmit(form: NgForm) {
    if (form.valid && this.isEditorContentValid()) {
      this.blogPostService.createPost(this.post).subscribe((createdPost) => {
        // Handle the success case
        console.log('Post created:', createdPost);
        form.resetForm(); // Clear the form
      });
    }
  }
}
