import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ExcerptLoopComponent } from './excerpt-loop.component';

describe('ExcerptLoopComponent', () => {
  let component: ExcerptLoopComponent;
  let fixture: ComponentFixture<ExcerptLoopComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ExcerptLoopComponent]
    });
    fixture = TestBed.createComponent(ExcerptLoopComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
