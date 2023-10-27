import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IllustratorDetailsComponent } from './illustrator-details.component';

describe('IllustratorDetailsComponent', () => {
  let component: IllustratorDetailsComponent;
  let fixture: ComponentFixture<IllustratorDetailsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [IllustratorDetailsComponent]
    });
    fixture = TestBed.createComponent(IllustratorDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
