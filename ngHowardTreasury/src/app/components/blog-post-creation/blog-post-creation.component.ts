import { Router } from '@angular/router';
import { BlogPostService } from 'src/app/services/blog-post.service';
import { Component, inject, Renderer2, OnInit, ChangeDetectorRef, ElementRef, Inject, AfterViewInit, OnDestroy } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { NgForm } from '@angular/forms';
import { BlogPost } from 'src/app/models/blog-post';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';

@Component({
  selector: 'app-blog-post-creation',
  templateUrl: './blog-post-creation.component.html',
  styleUrls: ['./blog-post-creation.component.css']
})
export class BlogPostCreationComponent implements OnInit, AfterViewInit, OnDestroy {

  editorConfig: any;

  post: BlogPost = new BlogPost();
  private mutationObserver!: MutationObserver;

  domSanitizer = inject(DomSanitizer);
  router = inject(Router);
  blogPostService = inject(BlogPostService);
  renderer = inject(Renderer2);
  breakpointObserver = inject(BreakpointObserver);
  cdr = inject(ChangeDetectorRef);
  el = inject(ElementRef);

  ngOnInit() {
    this.applyEditorConfiguration();

  }

  ngAfterViewInit() {
    this.setUpMutationObserver();
  }

  applyEditorConfiguration() {
      this.setDefaultEditorConfig();

  }

  setUpMutationObserver() {
    // Create a new observer instance linked to the callback function
    this.mutationObserver = new MutationObserver((mutationsList) => { // Removed unused 'observer'
      for (let mutation of mutationsList) {
        if (mutation.type === 'childList') {
          mutation.addedNodes.forEach((node) => {
            if (node instanceof HTMLElement && node.querySelector('.tox-promotion')) {
              this.hideToxPromotions();
            }
          });
        }
      }
    });

    // Start observing the target node for configured mutations
    this.mutationObserver.observe(this.el.nativeElement, {
      childList: true,
      subtree: true
    });
  }

  ngOnDestroy() {
    // Disconnect the observer when the component is destroyed
    this.mutationObserver.disconnect();
  }

  hideToxPromotions() {
    // Find all elements with the 'tox-promotion' class
    const promotions = this.el.nativeElement.querySelectorAll('.tox-promotion');
    // Set display style to 'none' for each element
    promotions.forEach((promotionElement: HTMLElement) => {
      this.renderer.setStyle(promotionElement, 'display', 'none');
    });
  }

  setDefaultEditorConfig() {
    console.log("set default editor config");
    this.editorConfig = {
      base_url: '/tinymce',
      suffix: '.min',
      // Add or remove plugins as per your need
      plugins: [
        'advlist autolink lists link image charmap preview anchor',
        'searchreplace visualblocks code fullscreen',
        'insertdatetime media table code help wordcount',
        'emoticons'
      ].join(' '), // Join the plugins with space to make it a string list
      toolbar: 'undo redo | styleselect | bold italic forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media | print preview fullpage | emoticons',
      menubar: 'file edit view insert format tools table help',
      toolbar_sticky: true,
      image_advtab: true,
      toolbar_mode: 'sliding',
      // ... other configuration options
    };
  }

  isEditorContentValid(): boolean {
    // Check if the editor content is not empty (you can add more specific checks here)
    return !!(this.post.content && this.post.content.trim().length > 0);
  }

  // onSubmit(form: NgForm) {
  //   if (form.valid && this.isEditorContentValid()) {
  //     this.blogPostService.createPost(this.post).subscribe((createdPost) => {
  //       console.log('Post created:', createdPost);
  //       form.resetForm();
  //     });
  //   }
  // }

  onSubmit(form: NgForm) {
    if (form.valid && this.isEditorContentValid()) {
      this.blogPostService.createPost(this.post).subscribe({
        next: (createdPost) => {
          console.log('Post created:', createdPost);
          this.post = createdPost;
          form.resetForm(); // Clear the form
          this.router.navigateByUrl(`posts/${this.post.id}/comments`);
        },
        error: (error) => {
          console.error('Error creating post', error);
        }
      });
    }
  }

}
