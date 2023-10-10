import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddToUserListDialogComponent } from './add-to-user-list-dialog.component';

describe('AddToUserListDialogComponent', () => {
  let component: AddToUserListDialogComponent;
  let fixture: ComponentFixture<AddToUserListDialogComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [AddToUserListDialogComponent]
    });
    fixture = TestBed.createComponent(AddToUserListDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
