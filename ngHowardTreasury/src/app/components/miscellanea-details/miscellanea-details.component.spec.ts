import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MiscellaneaDetailsComponent } from './miscellanea-details.component';

describe('MiscellaneaDetailsComponent', () => {
  let component: MiscellaneaDetailsComponent;
  let fixture: ComponentFixture<MiscellaneaDetailsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MiscellaneaDetailsComponent]
    });
    fixture = TestBed.createComponent(MiscellaneaDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
