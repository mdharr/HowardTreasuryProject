import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CreateUserListDialogComponent } from './create-user-list-dialog.component';

describe('CreateUserListDialogComponent', () => {
  let component: CreateUserListDialogComponent;
  let fixture: ComponentFixture<CreateUserListDialogComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CreateUserListDialogComponent]
    });
    fixture = TestBed.createComponent(CreateUserListDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
