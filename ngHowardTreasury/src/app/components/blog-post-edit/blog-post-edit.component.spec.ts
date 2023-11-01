import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BlogPostEditComponent } from './blog-post-edit.component';

describe('BlogPostEditComponent', () => {
  let component: BlogPostEditComponent;
  let fixture: ComponentFixture<BlogPostEditComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [BlogPostEditComponent]
    });
    fixture = TestBed.createComponent(BlogPostEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
