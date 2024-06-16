import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReactivateAccountRequestComponent } from './reactivate-account-request.component';

describe('ReactivateAccountRequestComponent', () => {
  let component: ReactivateAccountRequestComponent;
  let fixture: ComponentFixture<ReactivateAccountRequestComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ReactivateAccountRequestComponent]
    });
    fixture = TestBed.createComponent(ReactivateAccountRequestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
