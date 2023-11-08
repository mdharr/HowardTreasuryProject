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
  showEditor: boolean = true;

  post: BlogPost = new BlogPost();
  private mutationObserver!: MutationObserver;

  domSanitizer = inject(DomSanitizer);
  blogPostService = inject(BlogPostService);
  renderer = inject(Renderer2);
  breakpointObserver = inject(BreakpointObserver);
  cdr = inject(ChangeDetectorRef);
  el = inject(ElementRef);

  ngOnInit() {
    // Set initial configuration based on current window size
    this.breakpointObserver.isMatched('(max-width: 600px)')
    ? this.applyMobileEditorConfig()
    : this.setDefaultEditorConfig();
    this.applyEditorConfiguration();

    this.observeBreakpoints();
  }

  ngAfterViewInit() {
    this.setUpMutationObserver();
  }

  applyEditorConfiguration() {
    if (this.breakpointObserver.isMatched(Breakpoints.Handset)) {
      this.applyMobileEditorConfig();
    } else {
      this.setDefaultEditorConfig();
    }
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

  observeBreakpoints() {
    this.breakpointObserver.observe(['(max-width: 600px)']).subscribe((result) => {
      if (result.matches) {
        this.applyMobileEditorConfig();
      } else {
        this.setDefaultEditorConfig();
      }
      this.reloadEditor();
    });
  }

  reloadEditor() {
    // Additional log to trace editor reloading
    console.log("Reloading editor");

    this.showEditor = false;
    setTimeout(() => {
      this.showEditor = true;
      this.cdr.detectChanges(); // Ensure change detection is triggered after setting showEditor
    }, 0);
  }

  setDefaultEditorConfig() {
    console.log("set default editor config");
    this.editorConfig = {
      base_url: '/tinymce',
      suffix: '.min',
      plugins: 'lists link image table wordcount media searchreplace preview importcss fullscreen anchor autoresize pagebreak nonbreaking insertdatetime help emoticons directionality advlist accordion',
      toolbar: 'lists link image table wordcount media searchreplace preview importcss fullscreen anchor autoresize pagebreak nonbreaking insertdatetime help emoticons directionality advlist accordion undo blockquote align',
      image_advtab: true,
      menubar: true
    };
    this.reloadEditor();
  }

  applyMobileEditorConfig() {
    console.log("set mobile editor config");
    this.editorConfig = {
      selector: 'textarea',
      theme: 'silver',
      mobile: {
        theme: 'mobile',
        plugins: 'autosave lists autolink'
      }
    };
    this.reloadEditor();
  }


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
