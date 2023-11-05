import { ComponentFixture, TestBed } from '@angular/core/testing';

import { JumpToPageDialogComponent } from './jump-to-page-dialog.component';

describe('JumpToPageDialogComponent', () => {
  let component: JumpToPageDialogComponent;
  let fixture: ComponentFixture<JumpToPageDialogComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [JumpToPageDialogComponent]
    });
    fixture = TestBed.createComponent(JumpToPageDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
