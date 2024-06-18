import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SquishedImageComponent } from './squished-image.component';

describe('SquishedImageComponent', () => {
  let component: SquishedImageComponent;
  let fixture: ComponentFixture<SquishedImageComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [SquishedImageComponent]
    });
    fixture = TestBed.createComponent(SquishedImageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
