import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BlogPostCreationComponent } from './blog-post-creation.component';

describe('BlogPostCreationComponent', () => {
  let component: BlogPostCreationComponent;
  let fixture: ComponentFixture<BlogPostCreationComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [BlogPostCreationComponent]
    });
    fixture = TestBed.createComponent(BlogPostCreationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
