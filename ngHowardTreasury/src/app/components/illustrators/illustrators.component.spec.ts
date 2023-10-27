import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IllustratorsComponent } from './illustrators.component';

describe('IllustratorsComponent', () => {
  let component: IllustratorsComponent;
  let fixture: ComponentFixture<IllustratorsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [IllustratorsComponent]
    });
    fixture = TestBed.createComponent(IllustratorsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
