import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MiscellaneaComponent } from './miscellanea.component';

describe('MiscellaneaComponent', () => {
  let component: MiscellaneaComponent;
  let fixture: ComponentFixture<MiscellaneaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MiscellaneaComponent]
    });
    fixture = TestBed.createComponent(MiscellaneaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
