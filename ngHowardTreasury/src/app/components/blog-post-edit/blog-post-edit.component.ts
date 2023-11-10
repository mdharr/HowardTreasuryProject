import { Subscription } from 'rxjs';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { Component, inject, OnInit, OnDestroy, AfterViewInit, ChangeDetectorRef, ElementRef, Renderer2 } from '@angular/core';
import { NgForm } from '@angular/forms';
import { DomSanitizer } from '@angular/platform-browser';
import { BlogPost } from 'src/app/models/blog-post';
import { BlogPostService } from 'src/app/services/blog-post.service';
import { AuthService } from 'src/app/services/auth.service';
import { BreakpointObserver } from '@angular/cdk/layout';

@Component({
  selector: 'app-blog-post-edit',
  templateUrl: './blog-post-edit.component.html',
  styleUrls: ['./blog-post-edit.component.css']
})
export class BlogPostEditComponent implements OnInit, OnDestroy, AfterViewInit {

  editorConfig: any;

  post: BlogPost = new BlogPost();
  postId: number = 0;

  private mutationObserver!: MutationObserver;

  auth = inject(AuthService);
  activatedRoute = inject(ActivatedRoute);
  router = inject(Router);
  domSanitizer = inject(DomSanitizer);
  blogPostService = inject(BlogPostService);
  renderer = inject(Renderer2);
  breakpointObserver = inject(BreakpointObserver);
  cdr = inject(ChangeDetectorRef);
  el = inject(ElementRef);

  private paramsSubscription: Subscription | undefined;

  ngOnInit(): void {
    this.getRouteParams();
    this.applyEditorConfiguration();
    this.subscribeToPost();

  }

  ngOnDestroy() {
    if(this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
    // Disconnect the observer when the component is destroyed
    this.mutationObserver.disconnect();
  }

  getRouteParams = () => {
    this.paramsSubscription = this.activatedRoute.paramMap.subscribe((params: ParamMap) => {
      let idString = params.get('postId');
      if(idString) {
        this.postId = +idString;
      }
    });
  }

  subscribeToPost() {
    this.blogPostService.find(this.postId).subscribe((retrievedPost) => {
      this.post = retrievedPost;
    });
  }

  isEditorContentValid(): boolean {
    return !!(this.post.content && this.post.content.trim().length > 0);
  }

  onSubmit(form: NgForm) {
    if (form.valid && this.isEditorContentValid()) {
      this.updatePost(this.post);
    }
  }

  updatePost(post: BlogPost) {
    this.blogPostService.updatePost(post.id, post).subscribe({
      next: (updatedPost) => {
        this.post = updatedPost;
        this.router.navigateByUrl(`posts/${this.post.id}/comments`);
      },
      error: (error) => {
        console.error('Error updating comment', error);
      },
    });
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
}
