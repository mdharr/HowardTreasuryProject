import { Subscription } from 'rxjs';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { NgForm } from '@angular/forms';
import { DomSanitizer } from '@angular/platform-browser';
import { BlogPost } from 'src/app/models/blog-post';
import { BlogPostService } from 'src/app/services/blog-post.service';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-blog-post-edit',
  templateUrl: './blog-post-edit.component.html',
  styleUrls: ['./blog-post-edit.component.css']
})
export class BlogPostEditComponent implements OnInit, OnDestroy {
  editorConfig = {
    base_url: '/tinymce',
    suffix: '.min',
    plugins: 'lists link image table wordcount media searchreplace preview importcss fullscreen anchor autoresize pagebreak nonbreaking insertdatetime help emoticons directionality advlist accordion',
    toolbar: 'lists link image table wordcount media searchreplace preview importcss fullscreen anchor autoresize pagebreak nonbreaking insertdatetime help emoticons directionality advlist accordion undo blockquote align',
    image_advtab: true
  };

  post: BlogPost = new BlogPost();
  postId: number = 0;

  auth = inject(AuthService);
  activatedRoute = inject(ActivatedRoute);
  domSanitizer = inject(DomSanitizer);
  blogPostService = inject(BlogPostService);

  private paramsSubscription: Subscription | undefined;

  ngOnInit(): void {
    this.getRouteParams();
    this.subscribeToPost();
  }

  ngOnDestroy() {
    if(this.paramsSubscription) {
      this.paramsSubscription.unsubscribe();
    }
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
      },
      error: (error) => {
        console.error('Error updating comment', error);
      },
    });
  }
}
