import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DelReyCollectionsComponent } from './del-rey-collections.component';

describe('DelReyCollectionsComponent', () => {
  let component: DelReyCollectionsComponent;
  let fixture: ComponentFixture<DelReyCollectionsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DelReyCollectionsComponent]
    });
    fixture = TestBed.createComponent(DelReyCollectionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
